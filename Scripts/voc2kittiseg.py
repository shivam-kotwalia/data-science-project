import os
import shutil

print("Number of Total Images in JPEGImages : " + str(len(os.listdir("JPEGImages"))))
print("Number of Total Images in Segmentation Class  : " + str(len(os.listdir("SegmentationClass"))))

image_name = os.listdir("SegmentationClass")

if os.path.exists("data_voc2012"):
    shutil.rmtree("data_voc2012")

os.makedirs("data_voc2012/training/gt_image")
os.makedirs("data_voc2012/training/image")

SRC_PATH_SEG=os.path.join(os.getcwd(), "SegmentationClass")
SRC_PATH_JPG=os.path.join(os.getcwd(), "JPEGImages")

DEST_PATH=os.path.join(os.getcwd(), "data_voc2012", "training")
#myfile = open("data_voc2012/train.txt", "wb")
for image in image_name:
    shutil.copy(SRC_PATH_SEG + "/" +image, DEST_PATH + "/gt_image/" + image)
    shutil.copy(SRC_PATH_JPG + "/" +image.split(".")[0] + ".jpg", DEST_PATH + "/image/" + image.split(".")[0] + ".jpg")
    myfile.write("training/image/" + image.split(".")[0] + ".jpg" + " " + "training/gt_image/" + image + "\n")
    print("Processing Image : " + image)
    #break
#myfile.close()
print("done")
