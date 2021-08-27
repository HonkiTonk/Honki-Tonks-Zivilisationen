pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseEinheitenDatenbank, LeseStadtGebaut;

with EinheitSuchen, KIStadtLaufendeBauprojekte, EinheitenAllgemein;

package body KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         case
           EinheitenAllgemein.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => EinheitenSchleifenwert)
         is
            when True =>
               EinheitBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                IDExtern               => EinheitenSchleifenwert);
               
            when False =>
               null;
         end case;
                     
      end loop EinheitenSchleife;
      
      return EinheitBewertet;
      
   end EinheitenBauen;
   
   
   
   procedure EinheitBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      Gesamtwertung := 0;
      Gesamtwertung := Gesamtwertung + KostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                           EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + NahrungKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 EinheitenIDExtern      => IDExtern);
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
      is
         when GlobaleDatentypen.Arbeiter =>
            Gesamtwertung := Gesamtwertung + ArbeiterBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               EinheitenIDExtern      => IDExtern);
            
         when GlobaleDatentypen.Nahkämpfer =>
            Gesamtwertung := Gesamtwertung + NahkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                  EinheitenIDExtern      => IDExtern);
            
         when GlobaleDatentypen.Fernkämpfer =>
            Gesamtwertung := Gesamtwertung + FernkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   EinheitenIDExtern      => IDExtern);
            
         when GlobaleDatentypen.Beides =>
            null;
            
         when GlobaleDatentypen.Sonstiges =>
            null;
            
         when GlobaleDatentypen.Leer =>
            null;
      end case;
      
      if
        Gesamtwertung <= 0
      then
         null;
         
      elsif
        EinheitBewertet.Bewertung < Gesamtwertung
      then
         EinheitBewertet := (IDExtern, Gesamtwertung);

      else
         null;
      end if;
      
   end EinheitBewerten;
   
   
   
   function ArbeiterBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MengeVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                     EinheitTypExtern    => GlobaleDatentypen.Arbeiter,
                                                                     GesuchteMengeExtern => 2);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Nahkämpfer);
      
      if
        MengeVorhanden = MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau = MinimaleSiedlerMenge
      then
         return 0;
         
      elsif
        MengeVorhanden = MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau = MinimaleSiedlerMenge
      then
         return -5;
         
      else
         return 10 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
      end if;
      
   end ArbeiterBewerten;
   
   
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MengeVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                     EinheitTypExtern    => GlobaleDatentypen.Nahkämpfer,
                                                                     GesuchteMengeExtern => AnzahlStädte);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Nahkämpfer);
        
      if
        MengeVorhanden = AnzahlStädte + AnzahlStädte
        or
          MengeVorhanden + MengeImBau = AnzahlStädte + AnzahlStädte
      then
         return 0;
         
      elsif
        MengeVorhanden > AnzahlStädte + AnzahlStädte
        or
          MengeVorhanden + MengeImBau > AnzahlStädte + AnzahlStädte
      then
         return -5;
         
      else
         return 5 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
      end if;
      
   end NahkämpferBewerten;
   
   
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MengeVorhanden := EinheitSuchen.MengeEinesEinheitenTypsSuchen (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                                                     EinheitTypExtern    => GlobaleDatentypen.Fernkämpfer,
                                                                     GesuchteMengeExtern => AnzahlStädte);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Fernkämpfer);
        
      if
        MengeVorhanden = AnzahlStädte + AnzahlStädte
        or
          MengeVorhanden + MengeImBau = AnzahlStädte + AnzahlStädte
      then
         return 0;
         
      elsif
        MengeVorhanden > AnzahlStädte + AnzahlStädte
        or
          MengeVorhanden + MengeImBau > AnzahlStädte + AnzahlStädte
      then
         return -5;
         
      else
         return 5 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
      end if;
      
   end FernkämpferBewerten;
   
   
   
   function KostenBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return -(LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                       IDExtern    => EinheitenIDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10);
      
   end KostenBewerten;
     
     
     
   function GeldKostenBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => GlobaleDatentypen.Geld)
        = GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return 5;
         
      elsif
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).GeldZugewinnProRunde
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => GlobaleDatentypen.Geld)
        < GlobaleKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde
      then
         return -10;
      
      else
         return 0;
      end if;
      
   end GeldKostenBewerten;
   
   
   
   function NahrungKostenBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => GlobaleDatentypen.Nahrung)
        = GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => GlobaleDatentypen.Nahrung)
        < GlobaleKonstanten.LeerStadt.Nahrungsproduktion
      then
         return -20;
      
      else
         return 0;
      end if;
      
   end NahrungKostenBewerten;
     
     
     
   function RessourcenKostenBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                 IDExtern           => EinheitenIDExtern,
                                                 WelcheKostenExtern => GlobaleDatentypen.Ressourcen)
        = GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
        - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitenIDExtern,
                                                   WelcheKostenExtern => GlobaleDatentypen.Ressourcen)
        < GlobaleKonstanten.LeerStadt.Produktionrate
      then
         return -20;
      
      else
         return 0;
      end if;
      
   end RessourcenKostenBewerten;

end KIEinheitenBauen;
