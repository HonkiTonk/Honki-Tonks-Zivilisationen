with ProduktionDatentypen;
with WichtigesKonstanten;
with SpeziesKonstanten;

with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseWichtiges;

with EinheitenanforderungenLogik;
with Fehlermeldungssystem;

with KIKonstanten;

with KIKriegErmittelnLogik;
with KIStadtLaufendeBauprojekteLogik;

package body KIEinheitenBauenLogik is

   function EinheitenBauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      -- AnzahlStädte sollte immer größer 0 sein, da nur bei vorhandenen Städten etwas gebaut werden sollte.
      -- AnzahlStädte mal übergeben und nicht mehr so einfach benutzen. äöü
      AnzahlStädte := EinheitenDatentypen.MaximaleEinheiten (LeseWichtiges.AnzahlStädte (SpeziesExtern => StadtSpeziesNummerExtern.Spezies));
      VorhandeneEinheiten := LeseWichtiges.AnzahlEinheiten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      
      if
        VorhandeneEinheiten >= 5 * AnzahlStädte
        or
          VorhandeneEinheiten >= LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      then
         return KIKonstanten.LeerEinheitenbewertung;
         
      else
         return EinheitenDurchgehen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end if;
      
   end EinheitenBauen;
   
   
   
   function EinheitenDurchgehen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      EinheitBewertet := KIKonstanten.LeerEinheitenbewertung;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         case
           EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                              IDExtern                 => EinheitenSchleifenwert)
         is
            when True =>
               Einheitwertung := EinheitBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                  IDExtern                 => EinheitenSchleifenwert);
               
               if
                 Einheitwertung <= KIKonstanten.LeerBewertung
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                           IDExtern                 => LeseEinheitenDatenbank.VerbesserungZu (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                              IDExtern      => IDExtern))
      is
         when True =>
            return KIDatentypen.BauenBewertung'First;
            
         when False =>
            null;
      end case;
              
      Gesamtwertung := KIKonstanten.LeerBewertung;
      
      Gesamtwertung := Gesamtwertung + HerstellungskostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                   EinheitenIDExtern        => IDExtern);
      Gesamtwertung := Gesamtwertung + GeldKostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                           EinheitenIDExtern        => IDExtern);
      Gesamtwertung := Gesamtwertung + NahrungKostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                              EinheitenIDExtern        => IDExtern);
      Gesamtwertung := Gesamtwertung + RessourcenKostenBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                 EinheitenIDExtern        => IDExtern);
      Gesamtwertung := Gesamtwertung + SpezielleEinheitBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                 IDExtern                 => IDExtern);
            
      Gesamtwertung := Gesamtwertung + KIDatentypen.BauenBewertung (LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                          IDExtern      => IDExtern));
      
      AnzahlPassierbarkeiten := 0;
      
      PassierbarkeitenSchleife:
      for PassierbarkeitSchleifenwert in EinheitenDatentypen.Passierbarkeit_Enum'Range loop
         
         case
           LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                  IDExtern             => IDExtern,
                                                  WelcheUmgebungExtern => PassierbarkeitSchleifenwert)
         is
            when True =>
               AnzahlPassierbarkeiten := AnzahlPassierbarkeiten + 1;
               
            when False =>
               null;
         end case;
         
      end loop PassierbarkeitenSchleife;
      
      case
        AnzahlPassierbarkeiten
      is
         when 0 =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "KIEinheitenBauenLogik.EinheitBewerten: Einheit: "
                                        & StadtSpeziesNummerExtern.Spezies'Wide_Wide_Image & " " & IDExtern'Wide_Wide_Image & " hat keine Passierbarkeit");
            Gesamtwertung := KIDatentypen.BauenBewertung'First;
            
         when 1 =>
            null;
            
         when others =>
            Gesamtwertung := Gesamtwertung + 15;
      end case;
      
      return Gesamtwertung;
      
   end EinheitBewerten;
   
   
   
   function SpezielleEinheitBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
   begin
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                             IDExtern      => IDExtern)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return ArbeiterBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                     EinheitenIDExtern        => IDExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum =>
            return Gesamtwertung + NahkämpferBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        EinheitenIDExtern        => IDExtern);
            
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            return Gesamtwertung + FernkämpferBewerten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                         EinheitenIDExtern        => IDExtern);
            
         when EinheitenDatentypen.Beides_Enum =>
            null;
            
         when EinheitenDatentypen.Einmalig_Enum =>
            null;
            
         when EinheitenDatentypen.Cheat_Enum =>
            return KIDatentypen.BauenBewertung'First;
            
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "KIEinheitenBauenLogik.SpezielleEinheitBewerten: Leere Einheitart, ID: "
                                        & IDExtern'Wide_Wide_Image & " Spezies: " & StadtSpeziesNummerExtern.Spezies'Wide_Wide_Image);
      end case;
      
      return KIKonstanten.LeerBewertung;
      
   end SpezielleEinheitBewerten;
   
   
   
   function ArbeiterBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      MengeVorhanden := LeseWichtiges.AnzahlArbeiter (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                  EinheitArtExtern         => EinheitenDatentypen.Arbeiter_Enum);
      
      if
        MengeVorhanden = MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau = MinimaleSiedlerMenge
      then
         return -20;
         
      elsif
        MengeVorhanden > MinimaleSiedlerMenge
        or
          MengeVorhanden + MengeImBau > MinimaleSiedlerMenge
      then
         return -50;
         
      else
         -- Auf die maximale Größe der ID und des KIDatentypen.BauenBewertung Datentyps achten. äöü
         return 220 + KIDatentypen.BauenBewertung (EinheitenIDExtern);
      end if;
      
   end ArbeiterBewerten;
   
   
   
   function NahkämpferBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                  EinheitArtExtern         => EinheitenDatentypen.Nahkämpfer_Enum);
        
      case
        KIKriegErmittelnLogik.IstImKrieg (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
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
               return KIKonstanten.LeerBewertung;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -50;
         
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
               return KIKonstanten.LeerBewertung;
         
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      MengeVorhanden := LeseWichtiges.AnzahlKämpfer (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      MengeImBau := KIStadtLaufendeBauprojekteLogik.GleicheEinheitArtBauprojekte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                  EinheitArtExtern         => EinheitenDatentypen.Fernkämpfer_Enum);
        
      case
        KIKriegErmittelnLogik.IstImKrieg (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when False =>
            if
              MengeVorhanden = 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau = 2 * AnzahlStädte
            then
               return KIKonstanten.LeerBewertung;
         
            elsif
              MengeVorhanden > 2 * AnzahlStädte
              or
                MengeVorhanden + MengeImBau > 2 * AnzahlStädte
            then
               return -50;
         
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
               return KIKonstanten.LeerBewertung;
         
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        EinheitenIDExtern = 1
        or
          StadtSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
      then
         null;
         
      else
         null;
      end if;
      
      return KIKonstanten.LeerBewertung;
      
      -- Da das System so wie es aktuell ist nicht korrekt funktioniert, wird vorübergehen hier mit 0 multipliziert, das später wieder entfernen. äöü
      -- return -(KIDatentypen.BauenBewertung (LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
      --                                                                                 IDExtern    => EinheitenIDExtern)
      --          / LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      --          / 10))
      --   * 0;
      
   end HerstellungskostenBewerten;
     
   
     
   function GeldKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        WichtigesKonstanten.LeerGeldZugewinnProRunde = LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                IDExtern           => EinheitenIDExtern,
                                                                                                WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
      then
         return 5;
         
      elsif
        LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) - LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                          IDExtern           => EinheitenIDExtern,
                                                                                                                                          WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        < WichtigesKonstanten.LeerGeldZugewinnProRunde
      then
         return -10;
      
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
   end GeldKostenBewerten;
   
   
   
   function NahrungKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        StadtKonstanten.LeerNahrungsproduktion = LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                          IDExtern           => EinheitenIDExtern,
                                                                                          WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) - LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                             IDExtern           => EinheitenIDExtern,
                                                                                                                                             WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        < StadtKonstanten.LeerNahrungsproduktion
      then
         return -20;
         
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
   end NahrungKostenBewerten;
     
     
     
   function RessourcenKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
   is
      use type KIDatentypen.BauenBewertung;
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        StadtKonstanten.LeerProduktionrate = LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                      IDExtern           => EinheitenIDExtern,
                                                                                      WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
      then
         return 5;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) - LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                         IDExtern           => EinheitenIDExtern,
                                                                                                                                         WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
        < StadtKonstanten.LeerProduktionrate
      then
         return -20;
      
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
   end RessourcenKostenBewerten;

end KIEinheitenBauenLogik;
