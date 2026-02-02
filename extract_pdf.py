#!/usr/bin/env python3
"""
Enhanced PDF Text Extractor for LaTeX Schedule PDFs

Features:
- Extract text from single or multiple PDFs
- Compare multiple schedules side-by-side
- Extract structured schedule information
- Better error handling and logging
- CLI interface with multiple options
"""

import sys
import argparse
from pathlib import Path
from typing import List, Dict, Optional
import re

# Try to import PDF library
try:
    from pypdf import PdfReader
    PDF_LIBRARY = "pypdf"
except ImportError:
    try:
        from PyPDF2 import PdfReader
        PDF_LIBRARY = "PyPDF2"
    except ImportError:
        print("❌ Error: No PDF library found. Install with:")
        print("   pip install pypdf")
        print("   or")
        print("   pip install PyPDF2")
        sys.exit(1)


class PDFExtractor:
    """Enhanced PDF text extraction with schedule parsing capabilities"""
    
    def __init__(self, verbose: bool = False):
        self.verbose = verbose
        
    def log(self, message: str):
        """Print message if verbose mode is enabled"""
        if self.verbose:
            print(f"ℹ️  {message}")
    
    def extract_text(self, pdf_path: Path) -> Optional[str]:
        """
        Extract all text from a PDF file
        
        Args:
            pdf_path: Path to the PDF file
            
        Returns:
            Extracted text or None on error
        """
        try:
            self.log(f"Reading {pdf_path.name}...")
            reader = PdfReader(str(pdf_path))
            
            if not reader.pages:
                print(f"⚠️  Warning: {pdf_path.name} has no pages")
                return None
            
            text = ""
            for i, page in enumerate(reader.pages, 1):
                self.log(f"  Extracting page {i}/{len(reader.pages)}")
                page_text = page.extract_text()
                if page_text:
                    text += page_text + "\n"
            
            self.log(f"✅ Extracted {len(text)} characters from {pdf_path.name}")
            return text
            
        except FileNotFoundError:
            print(f"❌ Error: File not found: {pdf_path}")
            return None
        except Exception as e:
            print(f"❌ Error extracting {pdf_path.name}: {e}")
            return None
    
    def parse_schedule_info(self, text: str) -> Dict[str, any]:
        """
        Parse schedule information from extracted text
        
        Args:
            text: Extracted PDF text
            
        Returns:
            Dictionary with parsed schedule information
        """
        info = {
            'title': None,
            'period': None,
            'courses': [],
            'raw_text': text
        }
        
        # Extract title
        title_match = re.search(r'HORARIO\s+DE\s+CLASES', text, re.IGNORECASE)
        if title_match:
            info['title'] = 'Horario de Clases'
        
        # Extract period
        period_match = re.search(r'Periodo\s+(\d{4}-\d)', text)
        if period_match:
            info['period'] = period_match.group(1)
        
        # Extract course names (basic pattern - can be enhanced)
        # Look for uppercase words that might be course names
        course_pattern = r'([A-ZÁÉÍÓÚÑ][A-ZÁÉÍÓÚÑ\s]{2,}(?:I{1,3})?)'
        potential_courses = re.findall(course_pattern, text)
        
        # Filter and deduplicate
        seen = set()
        for course in potential_courses:
            course = course.strip()
            if (len(course) > 5 and 
                course not in seen and 
                'HORARIO' not in course and
                'PERIODO' not in course):
                info['courses'].append(course)
                seen.add(course)
        
        return info
    
    def process_directory(self, directory: Path, pattern: str = "*.pdf") -> List[Dict]:
        """
        Process all PDF files in a directory
        
        Args:
            directory: Directory containing PDFs
            pattern: Glob pattern for PDF files
            
        Returns:
            List of dictionaries with filename and extracted text
        """
        pdf_files = list(directory.glob(pattern))
        
        if not pdf_files:
            print(f"⚠️  No PDF files found in {directory}")
            return []
        
        print(f"📚 Found {len(pdf_files)} PDF file(s)")
        results = []
        
        for pdf_file in sorted(pdf_files):
            text = self.extract_text(pdf_file)
            if text:
                results.append({
                    'filename': pdf_file.name,
                    'path': pdf_file,
                    'text': text
                })
        
        return results
    
    def compare_schedules(self, results: List[Dict]):
        """
        Compare multiple schedule PDFs and display side-by-side
        
        Args:
            results: List of extraction results
        """
        if len(results) < 2:
            print("⚠️  Need at least 2 PDFs to compare")
            return
        
        print("\n" + "="*80)
        print("📊 SCHEDULE COMPARISON")
        print("="*80 + "\n")
        
        for i, result in enumerate(results, 1):
            info = self.parse_schedule_info(result['text'])
            
            print(f"{i}. {result['filename']}")
            print(f"   Period: {info['period'] or 'Unknown'}")
            print(f"   Courses found: {len(info['courses'])}")
            
            if info['courses']:
                print(f"   Sample courses:")
                for course in info['courses'][:5]:
                    print(f"     • {course}")
                if len(info['courses']) > 5:
                    print(f"     ... and {len(info['courses']) - 5} more")
            
            print()


def main():
    """Main CLI interface"""
    parser = argparse.ArgumentParser(
        description="Extract and analyze text from LaTeX schedule PDFs",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Extract text from a single PDF
  python extract_pdf.py schedule.pdf
  
  # Extract from all PDFs in Schedules directory
  python extract_pdf.py --directory Schedules/
  
  # Compare multiple schedules
  python extract_pdf.py --compare Schedules/UScheduleSophie.pdf Schedules/UScheduleSergio.pdf
  
  # Parse schedule information
  python extract_pdf.py --parse schedule.pdf
  
  # Save output to file
  python extract_pdf.py schedule.pdf --output output.txt
        """
    )
    
    parser.add_argument(
        'input',
        nargs='*',
        help='PDF file(s) to process'
    )
    
    parser.add_argument(
        '-d', '--directory',
        type=Path,
        help='Process all PDFs in directory'
    )
    
    parser.add_argument(
        '-o', '--output',
        type=Path,
        help='Save output to file instead of stdout'
    )
    
    parser.add_argument(
        '-c', '--compare',
        action='store_true',
        help='Compare multiple schedule PDFs'
    )
    
    parser.add_argument(
        '-p', '--parse',
        action='store_true',
        help='Parse and display schedule information'
    )
    
    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        help='Enable verbose output'
    )
    
    parser.add_argument(
        '--pattern',
        default='*.pdf',
        help='Glob pattern for directory mode (default: *.pdf)'
    )
    
    args = parser.parse_args()
    
    # Initialize extractor
    extractor = PDFExtractor(verbose=args.verbose)
    
    # Determine input files
    results = []
    
    if args.directory:
        # Process directory
        results = extractor.process_directory(args.directory, args.pattern)
    elif args.input:
        # Process individual files
        for pdf_path in args.input:
            path = Path(pdf_path)
            text = extractor.extract_text(path)
            if text:
                results.append({
                    'filename': path.name,
                    'path': path,
                    'text': text
                })
    else:
        parser.print_help()
        return 1
    
    if not results:
        print("❌ No PDFs could be processed")
        return 1
    
    # Handle output modes
    output_lines = []
    
    if args.compare:
        # Compare mode - display comparison
        extractor.compare_schedules(results)
    elif args.parse:
        # Parse mode - display structured information
        for result in results:
            info = extractor.parse_schedule_info(result['text'])
            
            output_lines.append(f"\n{'='*80}")
            output_lines.append(f"📄 {result['filename']}")
            output_lines.append('='*80)
            output_lines.append(f"Period: {info['period'] or 'Unknown'}")
            output_lines.append(f"Courses: {len(info['courses'])}")
            
            if info['courses']:
                output_lines.append("\nCourse List:")
                for i, course in enumerate(info['courses'], 1):
                    output_lines.append(f"  {i}. {course}")
            
            output_lines.append("")
    else:
        # Default mode - output raw text
        for result in results:
            output_lines.append(f"\n{'='*80}")
            output_lines.append(f"File: {result['filename']}")
            output_lines.append('='*80)
            output_lines.append(result['text'])
    
    # Write output
    if output_lines:
        output_text = '\n'.join(output_lines)
        
        if args.output:
            try:
                args.output.write_text(output_text, encoding='utf-8')
                print(f"✅ Output saved to {args.output}")
            except Exception as e:
                print(f"❌ Error writing to {args.output}: {e}")
                return 1
        else:
            print(output_text)
    
    print(f"\n✅ Processed {len(results)} PDF(s) successfully using {PDF_LIBRARY}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
