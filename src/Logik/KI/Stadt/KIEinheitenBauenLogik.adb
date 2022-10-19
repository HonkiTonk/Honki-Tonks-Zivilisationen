pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with WichtigesKonstanten;
with StadtKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with EinheitenmodifizierungLogik;
with Fehler;

with KIKriegErmittelnLogik;
with KIStadtLaufendeBauprojekteLogik;

package body KIEinheitenBauenLogik is

   function EinheitenBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      -- 3 * AnzahlStädte sollte immer größer 0 sein, da nur bei vorhandenen Städten was gebaut werden sollte.
      -- AnzahlStädte mal übergeben und nicht mehr so einfach benutzen lassen. äöü
      AnzahlStädte := EinheitenDatentypen.MaximaleEinheiten (LeseWichtiges.AnzahlStädte (RasseExtern => StadtRasseNummerExtern.Rasse));
      VorhandeneEinheiten := LeseWichtiges.AnzahlEinheiten (RasseExtern => StadtRasseNummerExtern.Rasse);
      
      if
        VorhandeneEinheiten >= 5 * AnzahlStädte
        or
          VorhandeneEinheiten >= SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze
      then
         return KIKonstanten.LeerEinheitIDBewertung;
         
      else
         return EinheitenDurchgehen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end if;
      
   end EinheitenBauen;
   
   
   
   function EinheitenDurchgehen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitIDBewertung;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           EinheitenmodifizierungLogik.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                     IDExtern               => EinheitenSchleifenwert)
         is
            when True =>
               Einheitwertung := EinheitBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  IDExtern               => EinheitenSchleifenwert);
               
               if
                 Einheitwertung <= 0
               then
                  null;
         
               elsif
                 EinheitBewertet.Bewertung < Einheitwertung
               then
                  EinheitBewertet := (EinheitenSchleifenwert, Gesamtwertung);

               else
                  null;
               end if;
               
            when False =>
               null;
         end case;
                     
      end loop EinheitenSchleife;
      
      return EinheitBewertet;
      
   end EinheitenDurchgehen;
   
   
   
   function EinheitBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      Gesamtwertung := 0;
      
      Gesamtwertung := Gesamtwertung + HerstellungskostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                           EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + NahrungKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenKostenBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 EinheitenIDExtern      => IDExtern);
      Gesamtwertung := Gesamtwertung + SpezielleEinheitBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 IDExtern               => IDExtern);
      
      return Gesamtwertung;
      
   end EinheitBewerten;
   
   
   
   function SpezielleEinheitBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => StadtRasseNummerExtern.Rasse,
                                           IDExtern    => IDExtern)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return ArbeiterBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                     EinheitenIDExtern      => IDExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum =>
            return Gesamtwertung + NahkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        EinheitenIDExtern      => IDExtern);
            
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            return Gesamtwertung + FernkämpferBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         EinheitenIDExtern      => IDExtern);
            
         when EinheitenDatentypen.Beides_Enum =>
            null;
            
         when EinheitenDatentypen.PZB_Enum'Range =>
            null;
            
         when EinheitenDatentypen.Cheat_Enum =>
            return KIDatentypen.BauenBewertung'First;
            
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIEinheitenBauen.SpezielleEinheitBewerten: Leere Einheitart.");
      end case;
      
      return 0;
      
   end SpezielleEinheitBewerten;
   
   
   
   function ArbeiterBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlArbeiter (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                  EinheitArtExtern       => EinheitenDatentypen.Nahkämpfer_Enum);
      
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
         -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten. äöü
         return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
      end if;
      
   end ArbeiterBewerten;
   
   
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                  EinheitArtExtern       => EinheitenDatentypen.Nahkämpfer_Enum);
        
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
      is
         when False =>
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
               
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
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 10 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
            end if;
            
         when True =>
            if
              MengeVorhanden + MengeImBau < AnzahlStädte
            then
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 20 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
               
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
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 10 * (5 + KIDatentypen.BauenBewertung (EinheitenIDExtern));
            end if;
      end case;
      
   end NahkämpferBewerten;
   
   
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (RasseExtern => StadtRasseNummerExtern.Rasse);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                  EinheitArtExtern       => EinheitenDatentypen.Fernkämpfer_Enum);
        
      case
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => StadtRasseNummerExtern.Rasse)
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
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 5 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
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
               -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten.
               return 5 * (5 + KIDatentypen.BauenBewertung (EinheitenIDExtern));
            end if;
      end case;
      
   end FernkämpferBewerten;
   
   
   
   function HerstellungskostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      return -(KIDatentypen.BauenBewertung (LeseEinheitenDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern    => EinheitenIDExtern)
               / LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)
               / 10));
      
   end HerstellungskostenBewerten;
     
   
     
   function GeldKostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        WichtigesKonstanten.LeerGeldZugewinnProRunde = LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                IDExtern           => EinheitenIDExtern,
                                                                                                WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (RasseExtern => StadtRasseNummerExtern.Rasse) - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                                    IDExtern           => EinheitenIDExtern,
                                                                                                                                    WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        < WichtigesKonstanten.LeerGeldZugewinnProRunde
      then
         return -10;
      
      else
         return 0;
      end if;
      
   end GeldKostenBewerten;
   
   
   
   function NahrungKostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        StadtKonstanten.LeerNahrungsproduktion = LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                          IDExtern           => EinheitenIDExtern,
                                                                                          WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                                         IDExtern           => EinheitenIDExtern,
                                                                                                                                         WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        < StadtKonstanten.LeerNahrungsproduktion
      then
         return -20;
         
      else
         return 0;
      end if;
      
   end NahrungKostenBewerten;
     
     
     
   function RessourcenKostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is begin
      
      if
        StadtKonstanten.LeerProduktionrate = LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                      IDExtern           => EinheitenIDExtern,
                                                                                      WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) - LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                                     IDExtern           => EinheitenIDExtern,
                                                                                                                                     WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
        < StadtKonstanten.LeerProduktionrate
      then
         return -20;
      
      else
         return 0;
      end if;
      
   end RessourcenKostenBewerten;

end KIEinheitenBauenLogik;