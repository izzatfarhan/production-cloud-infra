from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Production FastAPI app running on Amazon Linux"}

@app.get("/health")
def health():
    return {"status": "OK"}
