from flask import Flask, jsonify
import random

app = Flask(__name__)

responses = [
    "Investments",
    "Smallcase",
    "Stocks",
    "buy-the-dip",
    "TickerTape"
]

@app.route("/api/v1", methods=["GET"])
def get_random_message():
    return jsonify({
        "message": random.choice(responses)
    })

@app.route("/")
def health():
    return "Application is running"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081)