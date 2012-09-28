from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'testapp.views.index'),
    url(r'^2$', 'testapp.views.another_fail'),
    # Examples:
    # url(r'^$', 'bugsnagdjango.views.home', name='home'),
    # url(r'^bugsnagdjango/', include('bugsnagdjango.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
