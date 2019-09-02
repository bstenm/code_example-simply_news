# simply_news

A new Flutter project.

## Getting Started

Articles are passed from server according to the following data structure:

`[{
    type: "definition",
    text: "sherpa",
    definition: "A man from Tibet that helps people visiting the Himalayas"
},{
    type: "vocab",
    text: "takes",
    lemma: "to take",
    pos: "verb, 3rd person singular present",
    examples: [
        "I take a train",
        "He takes a shower"
    ]
}]`

## ATTENTION

During the login/signup flow, the require auth parent component will re-build on successful authentication (when state is being updated) and will then redirect user to the page originally requested. Thus neither the Login orr Signup widget should perform a redirection.