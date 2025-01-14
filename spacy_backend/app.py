from flask import Flask, request, jsonify
import spacy

app = Flask(__name__)

# Load spaCy language model
nlp = spacy.load("en_core_web_sm")

@app.route("/extract", methods=["POST"])
def extract_requirements():
    data = request.json
    transcription = data.get("transcription", "")

    if not transcription:
        return jsonify({"error": "No transcription provided"}), 400

    # Define keywords and templates
    keywords_to_templates = {
    "login screen": "Create a Login Screen with Email and Password",
    "email": "Add Email Input Field",
    "password": "Add Password Input Field",
    "profile": "Create a User Profile Page",
    "dashboard": "Create a Dashboard for User Data",
    "edit": "Add Edit Functionality",
    "filter": "Add Filtering Feature",
    "analytics": "Include Analytics Dashboard",
    }

    # Match keywords in the transcription
    requirements = []
    for keyword, template in keywords_to_templates.items():
        if keyword in transcription.lower():
            requirements.append(template)
    print(f"Extracted requirements: {requirements}")
    return jsonify({"requirements": requirements})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
