from django.urls import path
from . import views


app_name = 'polls'
urlpatterns = [
    # ex /polls/
    path('', views.IndexView.as_view(), name='index'),
    # ex /polls/5/
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    # ex /polls/5/results/
    path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),
    # ex /polls/5/vote/
    path('<str:question_id>/vote/', views.vote, name='vote'),
    # Let's say you wanted to let users put stuff in your DB
    # like /polls/sql/?str
    path('sql/', views.sql_injector, name='sqlinject'),
    # ex /polls/search/
    path('search/', views.search, name='search'),
    # ex /polls/injector/
    path('<str:injector_str>/', views.inject, name='inject'),

]