library(splines)
library(signal)

# Routines that are needed for server.R
#
# ------ layout ----------------------------------
#

ts.to.df <- function(x){
  z<- data.frame(time(x), as.numeric(x))
  names(z)<-c("Jaar", deparse(substitute(x)) )
  #  z$Yr<-as.integer(floor(z$Jaar))
  #  z$Mn<-round((z$Jaar-z$Yr)*12,0)
  return(z)
}

cpalet= list( 
  rand="#cad4e8"
  , titel="#8b0000"
  , as="#d84467"
  , box= "#ffccdc"
  , binnen="#fffafa"
  , lijnkleur=c('#8b0000','#b71c39','#d84467','#f07092','#ff9cb8','#ffccdc',
                '#fffafa',
                '#cad4e8','#a5abd6','#8481c3','#6359b1','#40319e','#00008b')
  , vulkleur= c('#8b000028','#b71c3928','#d8446728','#f0709228','#ff9cb828','#ffccdc28',
                '#fffafa28',
                '#cad4e828','#a5abd628','#8481c328','#6359b128','#40319e28','#00008b28')
)

pretty.legend <-function(
  kleur=c(1,13)
  , ...){
  if (hasArg(lwd)){
    legend("topleft" , inset=c(+0.01, 0), xpd=TRUE # moves - this is for pt 16 h=350
           , bty="n" 
           , horiz=TRUE
           , cex=0.9
           , text.col=cpalet$titel
           , col=cpalet$lijnkleur[kleur]
           , ...
    )
    
  } else {
    legend("topleft" , inset=c(+0.01, 0), xpd=TRUE # moves - this is for pt 16 h=350
           , bty="n" 
           , horiz=TRUE
           , cex=0.9
           , text.col=cpalet$titel
           , fill=cpalet$vulkleur[kleur]
           , border=cpalet$lijnkleur[kleur]
           , ...
    )
  }
}

pretty.plot<-function(df
                      , xlim=NULL
                      , ylim=NULL
                      , type="l" 
                      , main=""
                      , xlab=""
                      , ylab=""
                      , lwd=1
                      , lty=1
                      , cex=0.75
                      , kleur=1
                      , ccloc=1
                      , pch=19
                      , add=FALSE
                      , source=NULL
                      , xat = NULL, yat=NULL
                      , ...
                      
){if(class(df) %in% c("ts", "zoo", "xts"))df<-ts.to.df(df)
  if(add==FALSE){
    a = 0.6
    b = 0.55
    if (xlab == "") a = 0.35
    if (ylab == "") b = 0.45
    par(mai= c(a, b, 0.5, 0.2), bg=cpalet$rand)
    a <- xlim
    if (is.null(xlim)){
      # eps<-(max(df[,1])-min(df[,1]))/100
      a<-c(min(df[,1]), max(df[,1]))
    }
    b <- ylim
    if (is.null(ylim)){
      eps<-(max(df[,2])-min(df[,2]))/100
      b<-c(min(df[,2])-eps, max(df[,2])+eps)
    }
    plot.new()
    plot.window( xlim=a
                 , ylim=b
                 , xaxs= "i"
                 , yaxs= "i" 
                 , main= ""
                 , xlab=""
                 , ylab=""
                 , bg=cpalet$binnen
                 , ...
    )
    #no box(), but
    r= par("usr")
    rect(r[1], r[3], r[2], r[4], col=cpalet$binnen, border=cpalet$box)
    
    axis(1
         , xaxs= "i"
         , tck = -0.02
         , line = 0
         , labels = NA # no labels yet
         , col= cpalet$box
         , at=xat
         
         
    )
    axis(side = 1
         , lwd = 0
         , line = -.7
         , cex.axis= 0.8 
         , adj = 0
         , col.axis= cpalet$as
         , at=xat
         
    )
    axis(2
         , yaxs= "i"
         , tck = -0.02
         , line = 0
         , labels = NA # no labels yet
         , col=cpalet$box
         , at=yat
    )
    axis(side = 2
         , las =1
         , lwd = 0
         , line = -.85
         , cex.axis= 0.8 
         , adj = 0
         , col.axis=cpalet$as
         , at=yat
    )
    
    title(main=main 
          , adj=0
          , cex.main= 1.2
          , font=1
          , col.main=cpalet$titel
    )
    
    title(xlab=xlab
          , adj=0.5
          , col.lab=cpalet$as
          , cex.lab= 0.9  
          , line=1.2
    )
    
    title( ylab=ylab
           , adj=0.5
           , col.lab=cpalet$as
           , cex.lab= 0.9  
           , line=1.2
    )
    if (is.null(yat)) yat=axTicks(2)
    for (i in yat) abline(h=i, col=cpalet$box)
    pretty.cc(ccloc=ccloc)  
    if (! is.null(source)) 
      mtext(source, col=cpalet$as
            , side=1, line=1.2, adj=0.98, cex=0.8)
    
  }
  if (type == "e") return
  if (type == "p" | type == "h") points(df[,c(1,2)]
                                        , pch=pch
                                        , cex=cex
                                        , lwd=lwd
                                        , type=type
                                        , col=cpalet$lijnkleur[kleur])
  if (type=="v"){
    r= par("usr") # for minimum y
    r2=tail(df[,1],1)
    r1=head(df[,1], 1)
    cu<-rbind(as.matrix(df), c(r2, r[3]))
    cu<-rbind(cu, c(r1,r[3]))
    polygon(cu, col=cpalet$vulkleur[kleur], border=cpalet$vulkleur[kleur])
    box(col=cpalet$box)    
  }
  
  if (type == 'a'){
    # area polygon when dim(df)[2]>2
    # print(dim(df))
    polygon(c(df[,1],rev(df[,1])),c(df[,2],rev(df[,3])), col=cpalet$vulkleur[kleur], border=cpalet$vulkleur[kleur])
    box(col=cpalet$box)  
  }
  
  if (add==TRUE){
    if (type == "l" | type == "s") lines(df, lwd=lwd, col=cpalet$lijnkleur[kleur], type=type, lty=lty)
  }
  else{
    if (lwd > 0 & (type == "l" | type == "s")) lines(df, lwd=lwd, col=cpalet$lijnkleur[kleur], type=type, lty=lty)
    
  }
  
}
pretty.palet <- function(FUN, kleur=0,...){
  kleur <-ifelse(kleur==0, cpalet$box, cpalet$lijnkleur[kleur])
  FUN(col=kleur, ...)
  
}

pretty.abline <- function(...){
  pretty.palet(abline,...)
}

pretty.text <- function(kleur=0, cex=0.8, ...){
  kleur <-ifelse(kleur==0, cpalet$titel, cpalet$lijnkleur[kleur])
  arguments<-list(...)
  arguments<-append(arguments, list(cex=cex, col=kleur))
  do.call(text, arguments)
}

pretty.cc <- function(ccloc=0){
  if (ccloc %in% c(1,3)){
    loc= ccloc
    l = -1.6
    a = 0.95
  } else {
    loc= ccloc-1
    l = -1.6
    a = 0.05
  }
  if (ccloc == 0) return
  mtext("CC J.B. van Rongen 2015\nhttps://mrooijer.shinyapps.io/graphic/"
        , col=cpalet$as
        , side=loc, line=l, adj=a, cex=0.8)
}
# ------- preRS ------------
preRS <- function(this.lm){
  this.anova <- anova(this.lm)
  tss <- sum(this.anova$"Sum Sq")
  pr <- residuals(this.lm)/(1 - lm.influence(this.lm)$hat)
  PRESS <- sum(pr^2)
  
  return(1-PRESS/tss)
}
# ------ load data --------
# 
load("./data/startData.Rda")
end.y=2016 #end.y[1]+(end.y[2]-1)/12

doen.tcr=0

source_table=data.frame(effect=c("amo", "enso", "soi", "pdo", "volcanoes", 
                                 "co2 recent", "co2 historic."
                                 , "lod recent", "lod historic."
                                 , "sunspots", "TSI", "TSI reconst."),
                        url=c("http://climexp.knmi.nl/data/iamo_ersst.dat"
                              , "http://www.esrl.noaa.gov/psd/people/cathy.smith/best/enso.ts.1mn.txt"
                              , "http://www.cgd.ucar.edu/cas/catalog/climind/SOI.signal.ascii"
                              , "http://www.ncdc.noaa.gov/teleconnections/pdo/data.csv"
                              , "http://climexp.knmi.nl/data/isaod_gl.dat"
                              , "ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt"
                              , "http://climexp.knmi.nl/data/iRCP45_CO2.dat"
                              , "http://datacenter.iers.org/eop/-/somos/5Rgv/latest/214"
                              , "http://hpiers.obspm.fr/eoppc/series/longterm/jpl_c.eop"
                              , "http://sidc.be/silso/INFO/monssninfocsv.php"
                              , "ftp://ftp.pmodwrc.ch/pub/data/irradiance/composite/DataPlots/ext_composite_42_64_1410.dat"
                              , "http://lasp.colorado.edu/data/sorce/tsi_data/TSI_TIM_Reconstruction.txt")
)

# ------ doen routine --------
# added 26-11: apply smooth factor to data and lm separately
# added 01-12: all factors normalized

normalized<-function(time.se) {
  if (sd(time.se) == 0) return(time.se)
  return((time.se-mean(time.se))/sd(time.se))
}

se.autoco2<-function(model.fit, model.mode="co2"){ # calculate se on co2: number
  se.rate= summary(model.fit)$coef[model.mode,2]
  q = acf(model.fit$res, plot=FALSE)$acf[2:3]
  theta = q[2]/q[1]
  nu = 1+2*q[1]/(1-theta)
  return(1.96*se.rate*sqrt(nu))
}

se.autocor<-function(model.fit){ # vector for each observation
  se.rate= predict(model.fit, se.fit=TRUE)$se.fit 
  q = acf(model.fit$res, plot=FALSE)$acf[2:3]
  theta = q[2]/q[1]
  nu = 1+2*q[1]/(1-theta)
  return(1.96*se.rate*sqrt(nu))
}

# ---- smoothers ------

my.golay<-function(model, span){
  # from library signal 
  # model is the time series
  if (span <= 0) return(model)
  #span from 0-120%
  span<- -1 + span +(span%%2)
  m1<-as.numeric(model)-sgolayfilt(model, p=3, n = max(span,5))
  return(model-m1)
}

my.loess<-function(model, span){
  if (span <= 0) return(model)
  #span from 0-120 months
  return(stl(model, s.window=max(12, span), t.window=span)$time.series[,2])
}

my.smoother<-function(i, model, span){
  a<-do.call(c("my.loess", "my.golay")[i], list(model,span))
  return(a)
}

doen<-function(
  co2.lag=0, 
  soi.lag=3,
  ssp.lag=3,
  vol.lag=7,
  amo.lag=5, 
  pdo.lag=-1,
  lod.lag =76, 
  model.keuze=1, # co2, lineair, spline
  data.keuze=1,
  smooth.way=2, # choice of smoother
  smooth.keuze=0, #smooth in showing
  smooth.keuze.b=0, # smooth in input
  y.lim=c(-1.1, 0.6),
  show.reg=TRUE,
  cel.keuze=NULL,
  seas.keuze=FALSE,
  deseas.way=1,
  start.year=1800,
  end.year= 2016, 
  norm.doen=TRUE,
  show.se=TRUE,
  x.lim=c(1880,2015), 
  predict=FALSE
){
  # print(c(start.year, end.year, end.y))
  #if (end.year >= 2010) end.year= end.y
  if (data.keuze==1) model<-gss.ts
  if (data.keuze==2) model<-ncd.ts
  if (data.keuze==3) model<-hc4.ts
  if (data.keuze==4) model<-jma.ts
  if (data.keuze==5) model<-kdc.ts
  if (data.keuze==6) model<-avg.ts
  if (data.keuze==7) model<-cr4.ts
  if (data.keuze==8) model<-ghc.ts
  if (data.keuze==9) model<-rss.ts
  if (data.keuze==10) model<-uah.ts
  if (data.keuze==11) model<-bkl.ts
  if (data.keuze==12) model<-hc3.ts
  if (data.keuze==13) model<-uah.6.ts
  end.y1=end(model)[1]+(end(model)[2]-1)/12
  end.y=min(end.year, end.y1)+0.0001
  yspan=y.lim
  start.y<-max(start.year, start(model)[1])
  model.original<-model
  model<-window(model, start=start.y, end=end.y)
  model.display<- window(model.original, start=x.lim[1], end=x.lim[2])
  # if(seas.keuze) smooth.keuze=max(1, smooth.keuze)
  if (smooth.keuze>0) {
    model.display<-my.smoother(smooth.way, model, smooth.keuze)
  }
   
  ens <- ens.ts
  amo <- amo.ts
  pdo <- pdo.ts
  co2 <- co2.ts
  vol <- vol.ts
  
  if (smooth.keuze.b>0) {
    model<-my.smoother(smooth.way, model, smooth.keuze.b)
    co2<-my.smoother(smooth.way, co2, smooth.keuze.b)
    ens<-my.smoother(smooth.way, ens, smooth.keuze.b)
    amo<-my.smoother(smooth.way, amo, smooth.keuze.b)
    pdo<-my.smoother(smooth.way, pdo, smooth.keuze.b)
    vol<-my.smoother(smooth.way, vol, smooth.keuze.b)
  }
  model.str<-c("GISS", "NOAA",
               "HADcrut", "JMA", "C&W", "Combined", "CRUTEM (land)", "GISS (land)"
               , "RSS (satellite)", "UAH (satellite)", "BEST", "Hadcrut-3"
               ,  "UAH (beta 6.0)")[data.keuze]
  
  year<- as.numeric(time(model))
  
  sh<-sin(pi*year); ch<-cos(pi*year);
  s0<-sin(2*pi*year); c0<-cos(2*pi*year)
  
  # use precompiled saros etc series. 
  
  sar<-window(saros, start=start.y, end=end.y)
  lu1<-window(lunar1, start=start.y, end=end.y)
  lu2<-window(lunar2, start=start.y, end=end.y)
  jup<-window(jupiter,start=start.y, end=end.y)
  tid<-window(tide, start=start.y, end=end.y)
  
  form <- "model ~ "
  
  
  co2<- log(window(lag(co2, -co2.lag), start=start.y, end=end.y))
  model.mode=c("co2", "lin", "ns")[model.keuze]
  if (model.keuze != 1) { 
    cd1=tail(co2, 1)
    cd2=head(co2,1)
    lin<-year # cd2+(cd1-cd2)*(year-start.y)/(end.y-start.y) 
  }
  
  form <-paste0(form, c("co2", "lin", "ns(lin, df=11)")[model.keuze])
  
  soi<- window(lag(ens, - soi.lag), start=start.y, end=end.y)
  if (soi.lag>=0) form <-paste0(form, "+soi")
  ssp<- window(lag(ssp.ts, - ssp.lag), start=start.y, end=end.y)
  if (ssp.lag>=0) form <-paste0(form, "+ssp")
  vol<- window(lag(vol, - vol.lag), start=start.y, end=end.y)
  if (vol.lag>=0) form <-paste0(form, "+vol")
  amo<- window(lag(amo, - amo.lag), start=start.y, end=end.y)
  if (amo.lag>=0) form <-paste0(form, "+amo")
  lod<- window(lag(lod.ts, - lod.lag), start=start.y, end=end.y)
  if (lod.lag>=0) form <-paste0(form, "+lod")
  pdo<- window(lag(pdo, - pdo.lag), start=start.y, end=end.y)
  if (pdo.lag>=0) form <-paste0(form, "+pdo")
  if(norm.doen){
    sar<-normalized(sar); lu1<-normalized(lu1); lu2<-normalized(lu2)
    jup<-normalized(jup); tid<-normalized(tid)
    soi<-normalized(soi); ssp<-normalized(ssp); vol<-normalized(vol)
    amo<-normalized(amo); lod<-normalized(lod); pdo<-normalized(pdo)
  }
  if (seas.keuze && deseas.way==1) form<-paste0(form, "+s0+c0+sh+ch")
  if (seas.keuze && deseas.way==2 && smooth.keuze.b <= 0 ) model<-model-stl(model, s.window="periodic")$time.series[,"seasonal"]
  if (! is.null(cel.keuze)) {
    for (i in 1:5) if (i %in% cel.keuze) form<-paste0(form, c("+sar","+lu1","+lu2","+jup","+tid")[i])
  }
  model.fit<<-lm(as.formula(form))
  add.txt=""
  if (show.reg) add.txt=sprintf("\nTrend in years %4.0f - %4.0f", start.y, round(end.y, 0))
  my.se= se.autocor(model.fit)
  if (show.se){
    pretty.plot(type="a", data.frame(time(model), model.fit$fitted+my.se, model.fit$fitted-my.se),
                , ccloc=5, kleur=13
                , ylim=yspan #, yat=seq(-1.2, 2.4, by=0.6)
                , xlim=c(x.lim[1], x.lim[2]+0.3)
                , main=sprintf("%s Temperature Anomaly (Baseline 1986-2005)%s", model.str, add.txt))
    pretty.plot(ts.to.df(model.original), kleur= ifelse(smooth.keuze>2,5,4), type="p", add=TRUE)
  }else{
    pretty.plot(ts.to.df(model.original), kleur= ifelse(smooth.keuze>2,5,4), type="p", ccloc=5
                , ylim=yspan #, yat=seq(-1.2, 2.4, by=0.6)
                , xlim=c(x.lim[1], x.lim[2]+0.3)
                , main=sprintf("%s Temperature Anomaly (Baseline 1986-2005)%s", model.str, add.txt))
  }
  if (smooth.keuze>2) pretty.plot(ts.to.df(model.display), kleur=3, type="l", add=T, lwd=2)
  doen.tcr<-log(2) * model.fit$coef['co2']
  if (show.reg){
    pretty.plot(data.frame(time(model), model.fit$fitted), lwd= 2, kleur=13, add=T)
    if (model.keuze== 1) {
      ci=log(2)*se.autoco2(model.fit, model.mode=model.mode)
      ttxt=paste0(sprintf("Fit: preRS= %2.4f\n", preRS(model.fit)),
                  sprintf("TCR: %2.4f +- %2.4f (95 perc. Conf. )\n", doen.tcr, ci))
    }
    if (model.keuze ==2 ){
      dec.lin=10*model.fit$coef['lin']          
      ci=10* se.autoco2(model.fit, model.mode=model.mode)
      
      #       ttxt = (substitute(
      #         paste("Fit: ",p, "\n",  mu, "=", m, ", (", sigma^2, "=", s2, ")\n"),
      #         list(p=round(preRS(model.fit), 2), m = round(dec.lin, 3), s2 = round(ci.lin, 3))))
      ttxt=paste0(sprintf("Fit: preRS= %2.4f\n", preRS(model.fit)),
                  sprintf("%2.4f +- %2.4f (95 perc. Conf. ) per decade\n", dec.lin, ci))
    }
    
    if (model.keuze ==3 )ttxt= sprintf("Fit: preRS=%2.4f\n[undefined] for NS\n", preRS(model.fit))
    xpos<-(x.lim[1]+2.9)
    ypos= (3*yspan[2]+yspan[1])/4 #ypos= (12*yspan[2]+yspan[1])/13
    
    pretty.text(x=xpos,y=ypos,kleur=13, adj=0, font=4, cex=1.1
                , labels=ttxt )
    first.txt<- "Data"
    if (smooth.keuze.b>0) first.txt<- sprintf("Data [%d months Smoothed]", smooth.keuze.b)
    pretty.legend(lwd=c(3,3), kleur=c(3,13), c(first.txt, "Fitted Model"))
  }
  if(predict) {
    period.length=round(x.lim[2]-end.year, 0)
    my.predict(
      start.year=start.y
      , norm.doen=norm.doen
      , end.year=end.y #-1/12 
      , model.keuze=model.keuze
      , period.length = period.length
      , ssp.lag=ssp.lag
      , lod.lag=lod.lag
    )}
}

my.predict <- function( start.year=1800
                        , end.year= 2014.75
                        , period.length = 30
                        , model.keuze = 1
                        , norm.doen= TRUE
                        , ssp.lag=3
                        , lod.lag=76
                        
)
{
  # data is assembled in model.fit
  sigma=1.96*summary(model.fit)$sigma
  # assume straight line from endpoint
  period.length=max(period.length, 2046.5-end.year)
  ssp<-window(lag(ssp.ts.e, -ssp.lag), start=end.year, end = end.year+period.length)
  lod<-window(lag(lod.ts.e, -lod.lag), start=end.year, end = end.year+period.length)
  co2<-window(log(co2.ts.e), start=end.year, end = end.year+period.length)
  co2.l<-window(log(co2.ts.l), start=end.year, end = end.year+period.length)
  co2.u<-window(log(co2.ts.u), start=end.year, end = end.year+period.length)
  sar<-window(saros, start=end.year, end = end.year+period.length)
  lu1<-window(lunar1, start=end.year, end = end.year+period.length)
  lu2<-window(lunar2, start=end.year, end = end.year+period.length)
  jup<-window(jupiter, start=end.year, end = end.year+period.length)
  tid<-window(tide, start=end.year, end = end.year+period.length)
  if(norm.doen){
    sar<-normalized(sar); lu1<-normalized(lu1); lu2<-normalized(lu2)
    jup<-normalized(jup); tid<-normalized(tid)
    ssp<-normalized(ssp); lod<-normalized(lod)
  }
  
  nd<-data.frame(co2=co2, lod=lod, ssp=ssp, sar=sar, lu1=lu1, lu2=lu2, jup=jup, tid=tid, 
                 soi=0, vol=0, amo=0, s0=0, c0=0, sh=0, ch=0)
  
  f<-predict(model.fit, newdata=nd)
  diff=0
  nd$co2<-co2.l
  f.l<-predict(model.fit, newdata=nd)
  nd$co2<-co2.u
  f.u<-predict(model.fit, newdata=nd)
  pretty.plot(add=T, kleur=12, type="a"
              , data.frame(time(co2), sigma+f.u-diff, f.l-sigma-diff))
  
  pretty.plot(kleur=12, add=T, ts(f, start=end.year, freq=12), lwd=2)
  pretty.plot(kleur=9, add=T, ts(sigma+f.u-diff, start=end.year, freq=12))
  pretty.plot(kleur=9, add=T, ts(-sigma+f.l-diff, start=end.year, freq=12))
  
}
