# jumpstart-gamemode-template
A gamemode template for usage in Garry's Mod

## Usage
Clone repository as a new gamemode directory. Rename changeme.txt and modify file to match your gamemode. Modify shared.lua to match your gamemode name, author, website, and contact email. New code may be placed anywhere within the gamemode subdirectory. Files will be included automatically, with file prefix indicating which environments the file should be executed in.

Files with the cl\* prefix will be included on clients. Files with the sh\* prefix will be included on clients and the server. Files with the sv\* prefix will be included on the server. Files with no matching prefix will not be included.
