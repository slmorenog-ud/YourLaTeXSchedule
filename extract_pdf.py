import sys

try:
    from pypdf import PdfReader
    print("Using pypdf")
except ImportError:
    try:
        import PyPDF2
        from PyPDF2 import PdfReader
        print("Using PyPDF2")
    except ImportError:
        print("No PDF library found")
        sys.exit(1)

def extract_text(pdf_path):
    try:
        reader = PdfReader(pdf_path)
        text = ""
        for page in reader.pages:
            text += page.extract_text() + "\n"
        return text
    except Exception as e:
        print(f"Error extracting text: {e}")
        return ""

if __name__ == "__main__":
    pdf_path = sys.argv[1]
    content = extract_text(pdf_path)
    print("---START CONTENT---")
    print(content)
    print("---END CONTENT---")
