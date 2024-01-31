def ecr = 'aws ecr get-login --no-include-email --region ap-south-1'
def ecrproc = ecr.execute()
ecrproc.waitFor()
String app =  "$APP_NAME"
def command =["aws","ecr","describe-images","--repository-name","$app","--region","ap-south-1","--query","reverse(sort_by(imageDetails,&imagePushedAt))[*].imageTags[0]"]
def proc = command.execute()

def output = proc.in.text
output=output.replaceAll("\"","").replaceAll(",","").replaceAll("\\[", "").replaceAll("\\]", "")
def array = output.tokenize() as String[]
def tags = array.findAll { it.startsWith('') }
if(tags.toList().size() > 30) {
        return tags.toList().subList(0,30)
}
else {
        return tags.toList().subList(0,tags.toList().size())
}

