Create a Dockerfile to deploy an Apache HTTP Server which hosts a custom main page

Build and see how many layers the image consists of

Run the image locally, inspect its status and logs, finally test that it responds as expected

Run a command inside the pod to print out the index.html file

Tag the image with ip and port of a private local registry and then push the image to this registry

Verify that the registry contains the pushed image and that you can pull it


Run a pod with the image pushed to the registry

Log into a remote registry server and then read the credentials from the default file

Create a secret both from existing login credentials and from the CLI

Create the manifest for a Pod that uses one of the two secrets just created to pull an image hosted on the relative private remote registry

Clean up all the images and containers
