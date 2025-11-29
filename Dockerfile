FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Use root for installation
USER root

# Copy the lock file
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Create a NEW environment (critical fix)
RUN mamba create --yes -n myenv --file /tmp/conda-linux-64.lock && \
    mamba clean --all -y -f

# Activate the new environment by default
ENV CONDA_DEFAULT_ENV=myenv
ENV PATH=/opt/conda/envs/myenv/bin:$PATH

# Fix permissions for Jupyter
RUN fix-permissions "/opt/conda" && \
    fix-permissions "/home/${NB_USER}"

# Switch back to normal user
USER $NB_UID

