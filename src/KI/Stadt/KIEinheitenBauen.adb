pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseEinheitenDatenbank, LeseStadtGebaut, LeseWichtiges;

with EinheitenModifizieren;
with KIKriegErmitteln, KIStadtLaufendeBauprojekte;

package body KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      AnzahlStädte := LeseWichtiges.AnzahlStädte (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      if
        LeseWichtiges.AnzahlEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse) > 3 * AnzahlStädte
      then
         return EinheitBewertet;
         
      else
         null;
      end if;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         case
           EinheitenSchleifenwert
         is
            when 45 =>
               -- Ist dazu da dass die KI den Alleskönner nicht baut, später anpassen/entfernen.
               exit EinheitenSchleife;
               
            when others =>
               null;
         end case;
         
         case
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
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
      
      MengeVorhanden := LeseWichtiges.AnzahlArbeiter (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Nahkämpfer);
      
      if
        MengeVorhanden = MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau = MinimaleSiedlerMenge
      then
         return 0;
         
      elsif
        MengeVorhanden > MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau > MinimaleSiedlerMenge
      then
         return -5;
         
      else
         return 20 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
      end if;
      
   end ArbeiterBewerten;
   
   
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Nahkämpfer);
        
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when False =>
            
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               return 20 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
               
            elsif
              MengeVorhanden = 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 2 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -5;
         
            else
               return 10 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
            end if;
            
         when True =>
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               return 20 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
               
            elsif
              MengeVorhanden = 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 5 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 5 * AnzahlStädte
            then
               return -5;
         
            else
               return 10 * (5 + GlobaleDatentypen.KostenLager (EinheitenIDExtern));
            end if;
      end case;
      
   end NahkämpferBewerten;
   
   
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekte.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                             EinheitArtExtern       => GlobaleDatentypen.Fernkämpfer);
        
      case
        KIKriegErmitteln.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when False =>
            if
              MengeVorhanden = 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 2 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -5;
         
            else
               return 5 + GlobaleDatentypen.KostenLager (EinheitenIDExtern);
            end if;
            
         when True =>
            if
              MengeVorhanden = 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 5 * AnzahlStädte
            then
               return 0;
         
            elsif
              MengeVorhanden > 5 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 5 * AnzahlStädte
            then
               return -5;
         
            else
               return 5 * (5 + GlobaleDatentypen.KostenLager (EinheitenIDExtern));
            end if;
      end case;
      
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
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse)
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
