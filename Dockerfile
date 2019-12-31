FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY BoxOfficeInitiative/*.csproj ./BoxOfficeInitiative/
COPY BoxOfficeInitiative.Tests/*.csproj ./BoxOfficeInitiative.Tests/
RUN dotnet restore

# copy everything else and build app
COPY BoxOfficeInitiative/. ./BoxOfficeInitiative/
RUN dotnet publish -c Release -o out

# unit_testrunner target for running unit tests
FROM build as unit_testrunner
ENV RESULT_FILE=/results/test_results.trx
COPY BoxOfficeInitiative.Tests/ ./BoxOfficeInitiative.Tests/
WORKDIR /app/BoxOfficeInitiative.Tests
RUN dotnet build
ENTRYPOINT dotnet test --logger\:trx\;LogFileName=$RESULT_FILE

# runtime target
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "BoxOfficeInitiative.dll"]
