module.exports = {
    /// The files to be ignored
    ignorePattern: ["\\.swp$", "\\.DS_Store$"],
    pathReplace: [ 
        {
            find: "", 
            replace: ""
        }
    ],
    fileReplace: [
        {
            "pattern": ".*", // Apply the changes to file matched
            "find": "\\", // Pattern of text
            "replace": "\\" // Replace the found text
        }
    ]
}