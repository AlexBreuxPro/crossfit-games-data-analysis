# crossfit-games-data-analysis
## Crossfit Games - Data Analysis &amp; Predictions

### How to Use
1. Download/Pull this repository locally
```shell
git pull git@github.com:AlexBreuxPro/crossfit-games-data-analysis.git 
```

2. Go to the pulled repository
```shell
cd YOUR_PATH/crossfit-games-data-analysis
```

3. Use docker compose to build the images, attach volumes, and launch containers
```shell
docker compose up --build
```
Do note:
- The image is based off the Docker Python standard image
- 2 volumes are created, to persist data: one for the notebook, and another one for the database, containing the crossfit games/open dataset
- A user has been created with the right set of permissions for the container & attached volumes

4. Open the Jupyter notebook instance
```shell
# This is the default location to open the instance
http://localhost:8888/tree?token=YOUR_TOKEN
```
You can retrieve the token by checking the container' logs.

5. Next steps
Next steps are on your side: feel free to modify the notebook, fetch additional data sources, ...

### Data Sources
> The crossfit games/open dataset used here comes from --> https://www.kaggle.com/datasets/tgomesjuliana/crossfit-games
> The data analysis shown in the notebook is also available in Kaggle --> https://www.kaggle.com/code/alexbreux/crossfit-games-data-analysis-predictions