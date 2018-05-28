library(simmer)
library(simmer.plot)
library(dplyr)
library(magrittr)
library(parallel)
set.seed(12345)

CapC5 = 3
Cap777 = 4
CapC130 = 2

#from campbell to bagram 

CampbellBagram<-trajectory("CampbellBagram") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 5, permanent = FALSE,name="CampBalt") %>%
  #campbell to baltimore
  seize("C130CampBalt",1) %>%
  timeout(5) %>%
  clone(n=2, 
        trajectory("BaltCampbell") %>%
          timeout(5) %>%
          release("C130CampBalt")%>%
          separate(),
        trajectory("BaltRam") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  clone(n=2,
                        trajectory("DohaRam") %>%
                          timeout(7.5) %>%
                          release("777RamDoha",1) %>%
                          separate(),
                        trajectory("DohaBagram") %>%
                          separate() %>%
                          #Doha to Bagram
                          batch(n = CapC130, timeout = 5.5, permanent = FALSE,name="DohaBagram") %>%
                          seize("C130DohaBagram",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = CampbellBagram.now) %>%
                          release("C130DohaBagram",1)))) %>%
  separate() 


#from bragg to bagram 

BraggBagram<-trajectory("BraggBagram") %>%
  #set_attribute(key = "my_key1", value = BraggBagram.now) %>%
  batch(n = CapC130, timeout = 4.5, permanent = FALSE,name="CampBalt") %>%
  #campbell to baltimore
  seize("C130BraggBalt",1) %>%
  timeout(4.5) %>%
  clone(n=2, 
        trajectory("BaltBragg") %>%
          timeout(4.5) %>%
          release("C130BraggBalt")%>%
          separate(),
        trajectory("BaltRam") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  clone(n=2,
                        trajectory("DohaRam") %>%
                          timeout(7.5) %>%
                          release("777RamDoha",1) %>%
                          separate(),
                        trajectory("DohaBagram") %>%
                          separate() %>%
                          #Doha to Bagram
                          batch(n = CapC130, timeout = 8, permanent = FALSE,name="DohaBagram") %>%
                          seize("C130DohaBagram",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = BraggBagram.now) %>%
                          release("C130DohaBagram",1)))) %>%
  separate() 


#from Lewis to bagram 

LewisBagram<-trajectory("LewisBagram") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 7, permanent = FALSE,name="LewisBalt") %>%
  #lewis to baltimore
  seize("C130LewisBalt",1) %>%
  timeout(7) %>%
  clone(n=2, 
        trajectory("BaltLewis") %>%
          timeout(7) %>%
          release("C130LewisBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to lakenheith
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltLaken") %>%
          seize("777BaltLaken",1) %>%
          timeout(8) %>%
          clone(n=2, 
                trajectory("LakenBalt") %>%
                  timeout(8) %>%
                  release("777BaltLaken",1) %>%
                  separate(),
                trajectory("LakenDoha") %>%
                  separate() %>%
                  #Lakenheith to Doha
                  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenDoha") %>%
                  seize("C5LakenDoha",1) %>%
                  timeout(8) %>%
                  clone(n=2,
                        trajectory("DohaLaken") %>%
                          timeout(8) %>%
                          release("C5LakenDoha",1) %>%
                          separate(),
                        trajectory("DohaBagram") %>%
                          separate() %>%
                          #Doha to Bagram
                          batch(n = CapC130, timeout = 8, permanent = FALSE,name="DohaBagram") %>%
                          seize("C130DohaBagram",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = CampbellBagram.now) %>%
                          release("C130DohaBagram",1)))) %>%
  separate() 

#from lewis to Manas 

LewisManas<-trajectory("LewisManas") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 7, permanent = FALSE,name="CampBalt") %>%
  #lewis to baltimore
  seize("C130LewisBalt",1) %>%
  timeout(7) %>%
  clone(n=2, 
        trajectory("BaltLewis") %>%
          timeout(7) %>%
          release("C130LewisBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to Lakenheith
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltLaken") %>%
          seize("777BaltLaken",1) %>%
          timeout(8) %>%
          clone(n=2,
                trajectory("LakenBalt") %>%
                  timeout(8) %>%
                  release("777BaltLaken",1) %>%
                  separate(),
                trajectory("LakenManas") %>%
                  separate() %>%
                  #Lakenheith to Manas
                  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenManas") %>%
                  seize("C5LakenManas",1) %>%
                  timeout(8) %>%
                  #set_attribute(key = "my_key2", value = CampbellBagram.now) %>%
                  release("C5LakenManas",1))) %>%
  separate()


#from Bragg to Manas 

BraggManas<-trajectory("BraggManas") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 4.5, permanent = FALSE,name="BraggBalt") %>%
  #lewis to baltimore
  seize("C130BraggBalt",1) %>%
  timeout(4.5) %>%
  clone(n=2, 
        trajectory("BaltBragg") %>%
          timeout(4.5) %>%
          release("C130BraggBalt")%>%
          separate(),
        trajectory("BaltRam") %>%
          separate()%>%
          #baltimore to ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2,
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamManas") %>%
                  separate() %>%
                  #Ramstein to Manas
                  batch(n = CapC5, timeout = 7.5, permanent = FALSE,name="RamManas") %>%
                  seize("C5RamManas",1) %>%
                  timeout(7.5) %>%
                  #set_attribute(key = "my_key2", value = CampbellBagram.now) %>%
                  release("C5RamManas",1))) %>%
  separate() 

#from Campbell to Manas 

CampManas<-trajectory("CampManas") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 5, permanent = FALSE,name="CampBalt") %>%
  #lewis to baltimore
  seize("C130CampBalt",1) %>%
  timeout(5) %>%
  clone(n=2, 
        trajectory("BaltCamp") %>%
          timeout(5) %>%
          release("C130CampBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to Lakenheith
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltLaken") %>%
          seize("777BaltLaken",1) %>%
          timeout(8) %>%
          clone(n=2,
                trajectory("LakenBalt") %>%
                  timeout(8) %>%
                  release("777BaltLaken",1) %>%
                  separate(),
                trajectory("LakenManas") %>%
                  separate() %>%
                  #Lakenheith to Manas
                  batch(n = CapC5, timeout =8, permanent = FALSE,name="LakenManas") %>%
                  seize("C5LakenManas",1) %>%
                  timeout(8) %>%
                  #set_attribute(key = "my_key2", value = CampbellBagram.now) %>%
                  release("C5LakenManas",1))) %>%
  separate() 

#Bragg to Kandahar

BraggKandahar<-trajectory("BraggKandahar") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 4.5, permanent = FALSE,name="BraggBalt") %>%
  #Bragg to baltimore
  seize("C130BraggBalt",1) %>%
  timeout(4.5) %>%
  clone(n=2, 
        trajectory("BaltBragg") %>%
          timeout(4.5) %>%
          release("C130BraggBalt")%>%
          separate(),
        trajectory("BaltRamstein") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  clone(n=2,
                        trajectory("DohaRam") %>%
                          timeout(7.5) %>%
                          release("777RamDoha",1) %>%
                          separate(),
                        trajectory("DohaKand") %>%
                          separate() %>%
                          #Doha to Kandahar
                          batch(n = CapC130, timeout = 5.5, permanent = FALSE,name="DohaKand") %>%
                          seize("C130DohaKand",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = BraggKandahar.now) %>%
                          release("C130DohaKand",1)))) %>%
  separate() 


#Campbell  to Kandahar

CampbellKandahar<-trajectory("CampbellKandahar") %>%
  #set_attribute(key = "my_key1", value = CampbellKandahar.now) %>%
  batch(n = CapC130, timeout = 5, permanent = FALSE,name="CampBalt") %>%
  #Bragg to baltimore
  seize("C130CampBalt",1) %>%
  timeout(5) %>%
  clone(n=2, 
        trajectory("BaltCamp") %>%
          timeout(5) %>%
          release("C130CampBalt")%>%
          separate(),
        trajectory("BaltRam") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  clone(n=2,
                        trajectory("DohaRam") %>%
                          timeout(7.5) %>%
                          release("777RamDoha",1) %>%
                          separate(),
                        trajectory("DohaKand") %>%
                          separate() %>%
                          #Doha to Kandahar
                          batch(n = CapC130, timeout = 5.5, permanent = FALSE,name="DohaKand") %>%
                          seize("C130DohaKand",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = CampbellKandahar.now) %>%
                          release("C130DohaKand",1)))) %>%
  separate() 


#Lewis  to Kandahar

LewisKandahar<-trajectory("LewisKandahar") %>%
  #set_attribute(key = "my_key1", value = LewisKandahar.now) %>%
  batch(n = CapC130, timeout = 7, permanent = FALSE,name="LewisBalt") %>%
  #Leiws to baltimore
  seize("C130LewisBalt",1) %>%
  timeout(7) %>%
  clone(n=2, 
        trajectory("BaltLewis") %>%
          timeout(7) %>%
          release("C130LewisBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  clone(n=2,
                        trajectory("DohaRam") %>%
                          timeout(7.5) %>%
                          release("777RamDoha",1) %>%
                          separate(),
                        trajectory("DohaKand") %>%
                          separate() %>%
                          #Doha to Kandahar
                          batch(n = CapC130, timeout = 5.5, permanent = FALSE,name="DohaKand") %>%
                          seize("C130DohaKand",1) %>%
                          timeout(5.5) %>%
                          #set_attribute(key = "my_key2", value = CampbellKandahar.now) %>%
                          release("C130DohaKand",1)))) %>%
  separate() 

#from campbell to Doha 

CampbellDoha<-trajectory("CampbellDoha") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 5, permanent = FALSE,name="CampBalt") %>%
  #campbell to baltimore
  seize("C130CampBalt",1) %>%
  timeout(5) %>%
  clone(n=2, 
        trajectory("BaltCampbell") %>%
          timeout(5) %>%
          release("C130CampBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to Lakenheith
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltLaken") %>%
          seize("777BaltLaken",1) %>%
          timeout(8) %>%
          clone(n=2, 
                trajectory("LakenBalt") %>%
                  timeout(8) %>%
                  release("777BaltLaken",1) %>%
                  separate(),
                trajectory("LakenDoha") %>%
                  separate() %>%
                  #Lakenheith to Doha
                  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenDoha") %>%
                  seize("C5LakenDoha",1) %>%
                  timeout(7.5) %>%
                  release("C5LakenDoha",1))) %>%
  separate() 

#from Bragg to Doha 

BraggDoha<-trajectory("BraggDoha") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 4.5, permanent = FALSE,name="CampBalt") %>%
  #campbell to baltimore
  seize("C130BraggBalt",1) %>%
  timeout(4.5) %>%
  clone(n=2, 
        trajectory("BaltCampbell") %>%
          timeout(4.5) %>%
          release("C130BraggBalt")%>%
          separate(),
        trajectory("BaltLaken") %>%
          separate()%>%
          #baltimore to Lakenheith
          batch(n = Cap777, timeout = 8, permanent = FALSE, name="BaltLaken") %>%
          seize("777BaltLaken",1) %>%
          timeout(8) %>%
          clone(n=2, 
                trajectory("LakenBalt") %>%
                  timeout(8) %>%
                  release("777BaltLaken",1) %>%
                  separate(),
                trajectory("LakenDoha") %>%
                  separate() %>%
                  #Lakenheith to Doha
                  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenDoha") %>%
                  seize("C5LakenDoha",1) %>%
                  timeout(8) %>%
                  release("C5LakenDoha",1))) %>%
  separate()

#from Lewis to Doha 

LewisDoha<-trajectory("LewisDoha") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC130, timeout = 7, permanent = FALSE,name="CampBalt") %>%
  #campbell to baltimore
  seize("C130LewisBalt",1) %>%
  timeout(7) %>%
  clone(n=2, 
        trajectory("BaltCampbell") %>%
          timeout(7) %>%
          release("C130LewisBalt")%>%
          separate(),
        trajectory("BaltRam") %>%
          separate()%>%
          #baltimore to Ramstein
          batch(n = Cap777, timeout = 8.5, permanent = FALSE, name="BaltRam") %>%
          seize("777BaltRam",1) %>%
          timeout(8.5) %>%
          clone(n=2, 
                trajectory("RamBalt") %>%
                  timeout(8.5) %>%
                  release("777BaltRam",1) %>%
                  separate(),
                trajectory("RamDoha") %>%
                  separate() %>%
                  #Ramstein to Doha
                  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
                  seize("777RamDoha",1) %>%
                  timeout(7.5) %>%
                  release("777RamDoha",1))) %>%
  separate()

# From Ramstein to Doha

RamsteinDoha<-trajectory("RamsteinDoha") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
  #campbell to baltimore
  seize("777RamDoha",1) %>%
  timeout(7.5) %>%
  release("777RamDoha")%>%
  separate()

# From Laken to Doha

LakenDoha<-trajectory("LakenDoha") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenDoha") %>%
  #campbell to baltimore
  seize("C5LakenDoha",1) %>%
  timeout(8) %>%
  release("C5LakenDoha")%>%
  separate()

# From Ramstein to Manas

RamsteinManas<-trajectory("RamsteinManas") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC5, timeout = 7.5, permanent = FALSE,name="RamManas") %>%
  #campbell to baltimore
  seize("C5RamManas",1) %>%
  timeout(7.5) %>%
  release("C5RamManas")%>%
  separate()

# From Laken to Manas

LakenManas<-trajectory("LakenManas") %>%
  #set_attribute(key = "my_key1", value = CampbellBagram.now) %>%
  batch(n = CapC5, timeout = 8, permanent = FALSE,name="LakenManas") %>%
  #campbell to baltimore
  seize("C5LakenManas",1) %>%
  timeout(8) %>%
  release("C5LakenManas")%>%
  separate()

# From Ramstein to Bagram 
#Ramstein to Doha
RamsteinBagram<-trajectory("RamsteinBagram") %>%
  batch(n = Cap777, timeout = 7.5, permanent = FALSE,name="RamDoha") %>%
  seize("777RamDoha",1) %>%
  timeout(7.5) %>%
  clone(n=2,
        trajectory("DohaRam") %>%
          timeout(7.5) %>%
          release("777RamDoha",1) %>%
          separate(),
        trajectory("DohaBagram") %>%
          separate() %>%
          #Doha to Bagram
          batch(n = CapC130, timeout = 8, permanent = FALSE,name="DohaBagram") %>%
          seize("C130DohaBagram",1) %>%
          timeout(5.5) %>%
          #set_attribute(key = "my_key2", value = BraggBagram.now) %>%
          release("C130DohaBagram",1)) %>%
  separate() 

travel <- mclapply(1:100, function(i) {
  simmer() %>%
    add_resource("C130CampBalt", CapC130) %>%
    add_resource("C130BraggBalt", CapC130) %>%
    add_resource("C130LewisBalt", CapC130) %>%
    add_resource("777BaltLaken",Cap777) %>%
    add_resource("C5LakenDoha", CapC5) %>%
    add_resource("C130DohaBagram", CapC130) %>%
    add_resource("777BaltRam",Cap777) %>%
    add_resource("C5RamManas", CapC5) %>%
    add_resource("C5LakenManas", CapC5) %>%
    add_resource("777RamDoha", Cap777) %>%
    add_resource("C130DohaKand",CapC130) %>%
    add_generator("CampbellBagram", CampbellBagram, function() (rexp(1,0.248))) %>%
    add_generator("BraggBagram", BraggBagram, function() (rexp(1,0.372))) %>%  
    add_generator("LewisBagram", LewisBagram, function() (rexp(1,0.1655))) %>%  
    add_generator("LewisManas", LewisManas, function() (rexp(1,0.1241))) %>%
    add_generator("BraggManas", BraggManas, function() (rexp(1,0.206))) %>%
    add_generator("CampManas", CampManas, function() (rexp(1,0.0827))) %>%
    add_generator("BraggKandahar", BraggKandahar,function() (rexp(1,0.3310))) %>%
    add_generator("CampbellKandahar",CampbellKandahar,function() (rexp(1,0.206))) %>%
    add_generator("LewisKandahar",LewisKandahar,function() (rexp(1,0.206))) %>%
    add_generator("BraggDoha",BraggDoha,function() (rexp(1,0.0413))) %>%
    add_generator("CampbellDoha",CampbellDoha,function() (rexp(1,0.0413))) %>%
    add_generator("LewisDoha",LewisDoha,function() (rexp(1,0.0827))) %>%
    add_generator("RamsteinDoha", RamsteinDoha,function() (rexp(1,0.0827))) %>%
    add_generator("LakenDoha", LakenDoha,function() (rexp(1,0.0827))) %>%
    add_generator("RamsteinManas", RamsteinManas,function() (rexp(1,0.0413))) %>%
    add_generator("LakenManas", LakenManas,function() (rexp(1,0.0413))) %>%
    add_generator("RamsteinBagram",RamsteinBagram,function() (rexp(1,0.0413))) %>%
    run() %>%
    wrap()
}, mc.set.seed=FALSE)

travel.data <-
  
  #get_mon_attributes(travel) %>%
  #get_mon_resources(travel) %>%
  get_mon_arrivals(travel) %>%
  dplyr::group_by(replication) %>%
  dplyr::summarise(mean=mean(end_time-start_time)) 

t.test(travel.data[["mean"]])