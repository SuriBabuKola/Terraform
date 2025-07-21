# <p align="center">Terraform</p>

## Terraform Introduction
* **Terraform** is an **Infrastructure as Code (IaC)** tool
* Developed by **HashiCorp**
* Used to **automate provisioning** of infrastructure (cloud or on-prem)
* **IaC (Infrastructure as Code):** Managing and provisioning infrastructure through code instead of manual processes. Think of it like writing code to build your servers and networks.
* **Use Terraform (Advantages):**
  * **Simple Code:** Easy to read and understand.
  * **Multi-Cloud Support:** Works with many cloud providers (AWS, Azure, GCP, VMware, etc.).
  * **Organized Code:** You can split your infrastructure code into multiple files for better organization.
  * **Dry Run (Plan):** See what changes Terraform will make *before* it actually makes them. No surprises!
  * **Import Existing:** You can bring resources you've already created (manually) into Terraform's management.
  * **Reusable Code (Modules):** Create reusable blocks of code to build similar resources faster.
  * **Idempotent:** Apply the same code multiple times, and you'll always get the same result. No accidental duplicates or changes.
* **Disadvantages:**
  * **Third-Party Tool:** Not always immediately updated for brand-new cloud services.
  * **Community Support:** Relies heavily on community for bug fixes and errors (less direct vendor support).

## Terraform Workflow (How it Works)
1. **Write Template:** You write `.tf` files (Terraform code) describing your desired infrastructure for a cloud provider.
2. **`terraform init`:** Sets up your working directory. It downloads necessary provider plugins (executables) based on what you've specified in your template. Think of it as setting up your toolbox.
3. **`terraform validate`:** Checks your code for syntax errors and ensures it's valid. Like a spell check for your infrastructure code.
4. **`terraform fmt`:** Automatically formats your Terraform code for consistency. Makes your code look neat.
5. **`terraform plan`:** Shows you exactly what Terraform will create, change, or destroy before it does anything. This is your **dry run.** Crucial for avoiding mistakes!
6. **`terraform apply`:** Executes the plan. It creates and manages your resources in the cloud.
7. **`terraform destroy`:** Deletes all resources managed by your Terraform configuration. Use with caution!

## Key Terraform Concepts
* **Provider:** The connection or plugin that allows Terraform to interact with a specific cloud vendor (e.g., Azure, AWS).
* **Resources:** The actual infrastructure components you want to create (e.g., Virtual Machine, Resource Group, Network).

## Terraform Files (Common Ones)
* **`main.tf`:** Often contains the main provider configuration and some resource definitions.
* **`deployment.tf`:** Can contain specific resource deployments. (Good practice to split for organization).
* **`variable.tf`:** Defines input variables for your Terraform code (e.g., VM size, region).
* **`terraform.tfvars`:** Provides values for the variables defined in `variable.tf`.
* **`terraform.lock.hcl`:** Locks the provider versions used to ensure consistent deployments.
* **`terraform.tfstate`:** The "state file." This file keeps track of the actual resources Terraform has deployed and their configuration. **Crucial! Don't delete it manually.**

## Installing Terraform
### Method:1 `Manual (Universal for all OS)`
* Search `Install Terraform` and Go to the official Terraform website.
* [Refer Here](https://developer.hashicorp.com/terraform/install) for the Official site.
* Download the executable for your operating system (Windows, macOS, Linux).
* Unzip the downloaded file.
* Place the `terraform.exe` (or `terraform` on Linux/macOS) in a directory.
* **Add the directory path to your system's PATH environment variable.** This lets you run `terraform` commands from any directory in your terminal.
  * **Windows:**
    * Go to `This PC` → `Right-click` → `Properties`
    * In `System`, go to `Advanced System Settings` → `Environment Variables`
    * Under `User variables` (or `System variables` if for all users), Select `Path` and Click `Edit`.
    * Click `New` and paste the folder path where `terraform.exe` is located. Click `OK`.
    * **Verify:** Open a new terminal/command prompt and type `terraform --version`.
### Method:2 `Using a Package Manager (Recommended for Windows-Chocolately)`
* **Install Chocolately:**
  * Search `Install chocolately for windows` and Follow the Official docs.
  * Open PowerShell/CMD **as Administrator**.
  * Run the Chocolately installation command.
* **Install Terraform with Chocolately:**
  * Open PowerShell/CMD **as Administrator**.
  * Search `Install terraform using chocolately` and run the command (e.g., `choco install terraform`).
  * **Verify:** Open a new terminal/command prompt and type `terraform --version`.

## Setting Up Your Azure Environment for Terraform
* Before Terraform can create resources in Azure, it needs permission to talk to your Azure subscription.
### Create an Azure Service Principal (App Registration)
* This acts as a `service identity` for Terraform.
  * Go to **Azure Active Directory**
  * In **Manage**, go to **App registrations** → **New registration**
    * Give `Name` and click **Register**
  * Copy and Save:
    * **Application (client) ID**
    * **Directory (tenant) ID**
### Generate a Client Secret
* This is the `password` for your Service Principal.
  * Go to created App Registration (`terraform-sp`)
  * In **Manage**, click **Certificates & secrets**
  * Under **Client secrets**, click **New client secret**
    * Give `Description` and set an `Expires`
    * Click **Add**
  * Copy and Save:
    * **Secret Value** (this is shown only once!)
### Get your Azure Subscription ID
* Go to **Subscriptions** in Azure Portal
* Copy and Save:
  * Your **Subscription ID**
### Grant Permissions to the Service Principal
* Go to **Subscriptions** → Select your desired Subscription
* Go to **Access Control (IAM)** → **Add** → **Add role assignment**
  1. In **Role:**
     * Select **Privileged administrator roles**
     * Choose `Contributor` (**Contributor:** Allows Creating/Deleting resources but not managing permissions & **Owner:** Gives full control.)
  2. In **Members:**
     * **Assign access to:** `User, group, or service principal`
     * **Members:** Click `Select members`
        * In Search bar, Search with ServicePrinciple Name (`terraform-sp`)
        * Choose required one and click **Select**
  3. In **Review + assign:**
     * Review all details and click `Review + assign`.

## Create First Azure Resource `(Create a Resource Group)`
* **Open VS Code and Create a New File:**
  * Create a file named `main.tf` in a new, empty directory.
* **Add Provider Block:**
  * This block specifies the Azure provider and its configuration.
  * Search for `Terraform Azure Provider` and refer to the official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)).
    * Follow the `Example Usage` **or** click `USE PROVIDER`, copy, and use it.
    * In the Azure provider, it is necessary to use the `features {}` block.
         ```terraform
         terraform {
              required_providers {
                azurerm = {
                     source  = "hashicorp/azurerm"
                     version = "4.36.0"
                }
              }
         }
         
         provider "azurerm" {
              features {}    # Required for the AzureRM provider
         }
         ```
         1. The `terraform` block is used to specify the required versions.
         2. The `provider` block is used to specify the provider.
* **Provide Azure Authentication Details in the Provider Block:**
  * For connectivity purposes, you need to provide Azure authentication details.
  * Search for `Azure Authentication using Terraform` and refer to the official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)).
    * Based on the example, provide `client_id`, `client_secret`, `tenant_id`, and `subscription_id`.
         ```terraform
         provider "azurerm" {
              features {}     # Required for the AzureRM provider
              
              # Authentication details can be hardcoded for learning purposes, but using environment variables is recommended for security.
              client_id       = "YOUR_CLIENT_ID"
              client_secret   = "YOUR_CLIENT_SECRET"
              tenant_id       = "YOUR_TENANT_ID"
              subscription_id = "YOUR_SUBSCRIPTION_ID"
         }
         ```
* **Add a Resource Block for the Resource Group:**
  * Search for `Azure Resource Group using Terraform` and refer to the official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)).
  * Use the `Example Usage` and make the required changes like `name`, `location`, etc.
    ```terraform
    resource "azurerm_resource_group" "my-rg" {
         name     = "test-rg"   # Desired resource group name
         location = "East US"   # Desired Azure region
    }
    ```
    * `azurerm_resource_group`: The type of Azure resource.
    * `my-rg`: The local name you give this resource (can be anything).
    * `name`: The actual name of the resource group in Azure.
    * `location`: The Azure region for the resource group.
* **Deploy the Resource Group:**
  * Open a terminal and navigate to the directory containing your `main.tf` file.
  * Run the following commands in order:
    1. `terraform init` - Initializes the working directory and downloads the provider plugins.
    2. `terraform validate` - Validates the syntax and configuration of your Terraform code.
    3. `terraform fmt` - Formats your Terraform code for consistency.
    4. `terraform plan` - Previews the changes Terraform will make.
    5. `terraform apply` - Applies the changes to create the resource group. Type `yes` when prompted.
* **Verify the Resource Group:**
  * Log in to the Azure Portal and confirm that the resource group has been created.
* **Clean Up Resources:**
  * When you're done, run `terraform destroy` to delete the created resource group. Type `yes` when prompted.
* [Refer Here](https://github.com/SuriBabuKola/Terraform/commit/84556e79272d0220f1a063c0f94e6fa27db1c845) for the **`Resource Group`** Terraform Template.

## Terraform Resource: `Arguments` vs. `Attributes`
* Think of a resource as a function.
### Arguments (`Inputs`)
* These are the settings you give to the resource to create it. They are the parameters you write inside the resource block. Some are required, others are optional.
* **Example:**
  * In an `azurerm_resource_group`, `name` and `location` are required arguments. You must provide values for them.
  * [Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group#arguments-reference) for the `Resource Group Arguments Reference` Official docs.
### Attributes (`Outputs`)
* These are the pieces of information that become available after Terraform has created the resource. You can't set them yourself. They are used to get information from one resource to use in another.
* **Example:**
  * A resource group has an `id` or `name` attribute. You can reference this ID to put other resources inside that resource group.
  * [Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group#attributes-reference) for the `Resource Group Attributes Reference` Official docs.

## Referencing Resource Outputs
* To use the output of one resource as the input for another, you use a specific format:
* **Syntax:** `<resource_type>.<local_name>.<attribute_name>`
* **Example:**
  * You define a resource group: `resource "azurerm_resource_group" "my_rg" { ... }`
  * To get its name, you would use: `azurerm_resource_group.my_rg.name`
  * To get its ID, you would use: `azurerm_resource_group.my_rg.id`

## Key Terraform Flags
### `--auto-approve`
* **Purpose:** Automatically confirms the `terraform apply` command, so you don't have to type `yes` at the prompt.
* **Use Case:** Ideal for automation and scripting where manual intervention isn't possible.
* **Syntax:** `terraform apply --auto-approve`

## Organizing Your Terraform Files
* Terraform treats all `.tf` files in a single directory as one big configuration.
* **Best Practice:** Create separate files for different types of resources to keep your code clean and easy to understand.
  * `main.tf`: For providers and core configuration.
  * `network.tf`: For all network-related resources (VNet, subnets, etc.).
  * `compute.tf`: For virtual machines.
  * `variables.tf`: For all variable declarations.
  * `terraform.tfvars`: To store variable values.

## Creating a Network with Subnets in Azure
* This is a practical guide to creating a `Resource Group`, a `Virtual Network` and `Subnets` in Azure.
1. **Set up your Directory:**
   * Create a new, empty directory.
   * Inside it, create two files: `main.tf` and `network.tf`.
2. **`main.tf` (The Provider):**
   * Add the `Provider` and `Authentication` details. These are your credentials to connect to Azure.
   * Refer to the `Terraform Azure Provider` and `Azure Authentication using Terraform` Official documentation.
3. **`network.tf` (The Resources):**
   1. **Resource Group:**
      * Refer to the `Azure Resource Group using Terraform` Official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)).
      * Based on the `Example Usage` and `Argument Reference`, write the `Resource Group` template.
   2. **Virtual Network (VNet):**
      * Refer to the `Azure Virtual Network using Terraform` Official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)).
      * Based on the `Example Usage` and `Argument Reference`, write the `vNet Resource` template.
        ```terraform
        resource "azurerm_virtual_network" "terraform-vnet" {
           name                = "terraform-vnet"
           location            = azurerm_resource_group.terraform-rg.location
           resource_group_name = azurerm_resource_group.terraform-rg.name
           address_space       = ["10.0.0.0/16"]

           subnet {
              name             = "terraform-sub01"
              address_prefixes = ["10.0.1.0/24"]
           }
        }
        ```
          * **Note:** Use the `location` and `name` attributes of the **Resource Group**.
   3. **Add Another Subnet in vNet:**
      * Refer to the `Create Azure Subnet using Terraform` Official documentation ([Refer Here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)).
      * Based on the `Example Usage` and `Argument Reference`, write the `Subnet Resource` template.
        ```terraform
        resource "azurerm_subnet" "terraform-subnet" {
           name                 = "terraform-sub02"
           resource_group_name  = azurerm_resource_group.terraform-rg.name
           virtual_network_name = azurerm_virtual_network.terraform-vnet.name
           address_prefixes     = ["10.0.2.0/24"]
        }
        ```
          * **Note:** Use the `name` attributes of the **Resource Group** and **Virtual Network**.
   4. **Final Step:**
      * Run `terraform init`, `terraform plan`, and `terraform apply` to create the resources.
      * [Refer Here](https://github.com/SuriBabuKola/Terraform/commit/b86c4dba1c1ab7908800bdbc366fdfea9972a46b) for the **vNet with Subnet** Terraform Template.

## Using Variables
* **Variables:** Think of them as placeholders in your code. They make your code flexible and reusable without having to change the main template.
* [Refer Here](https://developer.hashicorp.com/terraform/language/values/variables) for the Official docs.
### `variables.tf` (Declaring the Variables)
* Create a file named `variables.tf`.
* Inside, you declare the variables you want to use. You can also provide a `default` value.
  * **Syntax:** `variable "<variable-name>" { ... }`
  * **Example:**
    ```terraform
    variable "resource_group_name" {
      description = "Resource Group Name"
      type        = string
      default     = "terraform-rg"
    }
    ```
* **Replace hardcoded values** in your `.tf` files with the variables.
  * **Syntax:** `var.<variable-name>`
  * **Example:** `name = var.resource_group_name`
* **Note:** If you do not provide a `default` value for a variable, Terraform will prompt you to enter a value during execution.
* [Refer Here](https://github.com/SuriBabuKola/Terraform/commit/9e1b43231e43c7520b8d9d389642786133bfd1b5) for using the Variables in Terraform Templates.
### `terraform.tfvars` (Providing the Values)
* This file is used to store values for your variables. Terraform automatically looks for a file named `terraform.tfvars`.
* If this file exists, Terraform will use the values inside it instead of the `default` values in `variables.tf`.
* **Example `terraform.tfvars` file:**
  ```
  resource_group_name = "dev-rg"
  resource_group_location = "East US"
  ```
* [Refer Here](https://github.com/SuriBabuKola/Terraform/commit/3d462bd2453f9bd434a3b6540c36a93da26e94ce) for the `terraform.tfvars` file.
### Using Multiple `.tfvars` Files
* **Use Case:** To manage different environments (e.g., dev, test, prod).
* **Process:**
  1.  Create separate files like `dev.tfvars` and `prod.tfvars`.
  2.  Use the `--var-file` flag with `terraform apply` to specify which file to use.
* **Syntax:** `terraform apply --var-file=<filename.tfvars>`
* **Example:**
  * To deploy to dev: `terraform apply --var-file=dev.tfvars`
  * To deploy to prod: `terraform apply --var-file=prod.tfvars`