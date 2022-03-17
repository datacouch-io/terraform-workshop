# Exercise #1: Using AWS provider with Terraform

Take a look at this directory.  You should see a couple of files aside from this README.

```bash
ls -lah
```

You'll see two .tf files:

### main.tf

Though the name of a terraform config file is mostly arbitrary, this is generally the name ascribed 
to the major configuration file within a Terraform working directory.

Inside, you will see the following:

```HCL
# Declare the provider being used, in this case it's AWS.
# This provider supports setting the provider version, AWS credentials as well as the region.
# It can also pull credentials and the region to use from environment variables, which we have set, so we'll use those
provider "aws" {
  version = "~> 3.0"
  access_key = <your-access-key-here>
  secret_key = <your-secret-key-here>
}

# declare a resource stanza so we can create something.
resource "aws_s3_bucket_object" "user_student_alias_object" {
  bucket  = "sm-di-<your-student-alias-here>"
  key     = "student.alias"
  content = "This bucket is reserved for <your-student-alias-here>"
}
```

This directory is a very simple example of a terraform project or module.

### Commands

So we have these files that make up our project, now what?  Well, let's try to run some terraform commands against them

```bash
# init is generally the first command you run after writing your config files.  It does 
# a few things but a simple way to thing about init: it initializes the working directory to prepare 
# it to run plans and applies
terraform init

# FMT is a very simple syntax corrector that analyzes HCL in a given directory 
# (including sub-directories) and corrects small syntactical issues.
terraform fmt

# "validate" runs a deeper scan of config to show potential issues with more complex 
# problems like circular dependencies and missing values. v0.12 made validate a bit simpler
# as far as the tasks it performs
terraform validate
```

If your "terraform init" command was successful, then you should be ready to move on. For now, don't run an apply.  
We will get to this in a future exercise.
