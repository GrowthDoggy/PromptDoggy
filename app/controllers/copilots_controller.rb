class CopilotsController < ApplicationController
  def prompts
    user_input = prompts_params[:input]
    client = OpenAI::Client.new
    # TODO: Host this prompt on the PromptDoggy's cloud version instead of hard coding it here
    messages = [
      {
        role: "system",
        content: "You are a senior prompt engineer. Your task helping the user finish the prompt based on the user's input.
Example 1:
User's input: I want to create a new
  {product management tool} that will help {product managers} to {collaborate with developers}.

Example 2:
User's input: Please act as a
  {customer service representative} and help the user with their {billing issue}.

Example 3:
User's input: I am a
  {product manager} and I need help with {creating a new product roadmap}.
"
      },
      {
        "role": "user",
        "content": "User's input: #{user_input}"
      }
    ]

    response = client.chat(
      parameters: {
        temperature: 0.7,
        messages: messages,
        max_tokens: 300
      }
    )
    content = response.dig("choices", 0, "message", "content")
    render json: { following_prompt: content }
  end


  private

  def prompts_params
    params.permit(:input)
  end
end
