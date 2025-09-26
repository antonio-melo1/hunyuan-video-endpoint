from fastapi import FastAPI
from pydantic import BaseModel
from HunyuanVideo.inference_pipeline import HunyuanVideoPipeline  # adjust import if needed

app = FastAPI()

# Load model once on startup
pipeline = HunyuanVideoPipeline(
    model_path="HunyuanVideo/models/pretrained",  # download/cache weights here
    device="cuda"
)

class GenerateRequest(BaseModel):
    prompt: str
    seconds: int = 10

@app.post("/generate")
def generate(req: GenerateRequest):
    # Run inference
    video_path = pipeline.generate_video(prompt=req.prompt, seconds=req.seconds)
    return {"videoUrl": video_path}
