Install Terraform : https://www.terraform.io/downloads
We are using a linux distribution but you will see from the documentation the other OS.

You need to set up an aws account
Create a user other than the rootUser and attache permissions on EC2 instances "AmazonEC2FullAccess"
You can download the creaditial in a file or just copy those by showing them (beware if you don't download the file you won't be able to retrieve those credentials again)
If you download the creaditial, the file will display the url to login to the AWS Console with the new user.

Install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
sudo apt install awscli

Your can configure the AWS CLI with the following commands for your credentials or just export the credentials: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

aws configure # then file in the fields

OR export the credentials:

<code>
$ export AWS_ACCESS_KEY_ID="<your_access_key_id>"
</code>
<code>
$ export AWS_SECRET_ACCESS_KEY="<your_secret_access_key>"
</code>

Then, enter those commands to deploy your infrastructure:

# to initialize the terraform root folder
<code>
$ terraform init
</code>

# optional
<code>
$ terraform fmt
</code>

# optional
<code>
$ terraform validate
</code>

# to see what is expected to be deployed and how it will potentially be applied
<code>
$ terrafrom plan
</code>

# you will be promted with Y/N choice, say "y" , optionally for automatisation you have the option "--auto-approve" available to valide the prompt (Y/N choice).
<code>
$ terraform apply
</code>

After than you can go to your AWS console and see the instance running. Terraform will output the public IP of your instance.
Put the public in your browser to see the apache server running your page with your message.

Hope that you will be successful and that you enjoyed this little deployment.