package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os/exec"
	"strings"
)

const shell = "/bin/sh"
const gitVersionScript = "Scripts/ChangeVersion/git-version.sh"
const xCodeProjFilePath = "PassLibrary.xcodeproj/project.pbxproj"

func main() {
	gitBranchBytes, err := exec.Command(shell, gitVersionScript).Output()
	if err != nil {
		log.Fatalln(err)
	}
	currentBranch := string(gitBranchBytes)
	splittedBranchName := strings.Split(currentBranch, "/")
	isReleaseBranch := splittedBranchName[0] == "release"
	if isReleaseBranch {
		versionNumber := splittedBranchName[1]
		xCodeProjBytes, err := ioutil.ReadFile(xCodeProjFilePath)
		if err != nil {
			log.Fatalln(err)
		}
		lines := strings.Split(string(xCodeProjBytes), "\n")
		hasChanges := false
		for lineNumber, line := range lines {
			if strings.Contains(line, "MARKETING_VERSION = ") {
				oneTab := "	"
				amountOfTabs := strings.Count(line, oneTab)
				tabsToAdd := ""
				for i := 0; i < amountOfTabs; i++ {
					tabsToAdd += oneTab
				}
				newString := tabsToAdd + "MARKETING_VERSION = " + versionNumber + ";"
				if lines[lineNumber] != newString {
					fmt.Println(lines[lineNumber], "in to:")
					fmt.Println(newString)
					lines[lineNumber] = newString
					hasChanges = true
				}

			}
		}
		if hasChanges {
			output := strings.Join(lines, "\n")
			err = ioutil.WriteFile(xCodeProjFilePath, []byte(output), 0644)
			if err != nil {
				log.Fatalln(err)
			}
			return
		}
	}
	fmt.Println("No changes made to XCodeProj file")
}
