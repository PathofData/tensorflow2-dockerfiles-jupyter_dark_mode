RUN apt-get install -y graphviz
RUN ${PIP} install jupyter matplotlib jupyterthemes pandas scikit-learn pydot
RUN ${PIP} install git+https://www.github.com/keras-team/keras-contrib.git
RUN ${PIP} install jupyter_http_over_ws
RUN jupyter serverextension enable --py jupyter_http_over_ws

RUN mkdir -p /tf/tensorflow-tutorials && chmod -R a+rwx /tf/
RUN mkdir /.local && chmod a+rwx /.local
RUN apt-get install -y --no-install-recommends wget
WORKDIR /tf/tensorflow-tutorials
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/classification.ipynb
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/overfit_and_underfit.ipynb
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/regression.ipynb
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/save_and_load.ipynb
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/text_classification.ipynb
RUN wget https://raw.githubusercontent.com/tensorflow/docs/master/site/en/tutorials/keras/text_classification_with_hub.ipynb

RUN apt-get autoremove -y && apt-get remove -y wget
WORKDIR /tf
EXPOSE 8888

RUN ${PYTHON} -m ipykernel.kernelspec

RUN jt -t onedork -fs 95 -tfs 11 -nfs 115 -cellw 88% -T

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]
