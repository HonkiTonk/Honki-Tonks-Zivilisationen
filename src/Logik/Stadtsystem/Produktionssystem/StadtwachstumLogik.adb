with EinheitenDatentypen;
with StadtDatentypen;
with StadtKonstanten;
with KartenverbesserungDatentypen;
with SystemDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with StadtwerteFestlegenLogik;
with StadtEinheitenBauenLogik;
with StadtGebaeudeBauenLogik;
with StadtEntfernenLogik;
with SichtbarkeitsberechnungssystemLogik;
with MeldungenSetzenLogik;

package body StadtwachstumLogik is
   
   procedure StadtWachstum
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseSchleifenwert) loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert))
                  is
                     when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                        null;
               
                     when others =>
                        WachstumEinwohner (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert));
                        WachstumProduktion (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert));
                  end case;
            
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end StadtWachstum;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                          ÄndernSetzenExtern     => True);
      
      VorhandeneNahrung := LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        VorhandeneNahrung > BenötigteNahrung (StadtRasseNummerExtern => StadtRasseNummerExtern)
      then
         WachstumSchrumpfung := NeuerEinwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      elsif
        VorhandeneNahrung < StadtKonstanten.LeerNahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             NahrungsmittelExtern   => StadtKonstanten.LeerNahrungsmittel,
                                             ÄndernSetzenExtern     => False);
         
         case
           LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                              EinwohnerArbeiterExtern => True)
         is
            when 1 =>
               StadtEntfernenLogik.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               StadtwerteFestlegenLogik.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                                       StadtRasseNummerExtern   => StadtRasseNummerExtern);
               WachstumSchrumpfung := False;
         end case;
                  
      else
         return;
      end if;

      EinwohnerÄnderung (StadtRasseNummerExtern    => StadtRasseNummerExtern,
                          WachstumSchrumpfungExtern => WachstumSchrumpfung);
      
   end WachstumEinwohner;
   
   
   
   function BenötigteNahrung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return GrundwertEinwohnerwachstum (StadtRasseNummerExtern.Rasse)
        + MultiplikatorEinwohnerwachstum (StadtRasseNummerExtern.Rasse) * ProduktionDatentypen.Produktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                              EinwohnerArbeiterExtern => True));
      
   end BenötigteNahrung;
   
   
   
   function NeuerEinwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => StadtKonstanten.LeerNahrungsmittel,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             WachsenSchrumpfenExtern => True);
      StadtwerteFestlegenLogik.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                              StadtRasseNummerExtern   => StadtRasseNummerExtern);
      
      return True;
      
   end NeuerEinwohner;
   
   
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                EinwohnerArbeiterExtern => True);
      
      case
        WachstumSchrumpfungExtern
      is
         when True =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     EreignisExtern         => StadtDatentypen.Einwohner_Wachstum_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse)
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
            then
               StadtwerteFestlegenLogik.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     EreignisExtern         => StadtDatentypen.Einwohner_Reduktion_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse) - 1
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse) - 1
            then
               StadtwerteFestlegenLogik.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end EinwohnerÄnderung;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                      ÄndernSetzenExtern     => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
        
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                         ÄndernSetzenExtern     => False);
         
      elsif
        Bauprojekt.Gebäude /= 0
      then
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern) >= LeseGebaeudeDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                                     IDExtern    => StadtDatentypen.GebäudeID (Bauprojekt.Gebäude))
         then
            StadtGebaeudeBauenLogik.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            null;
         end if;
         
      else
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern) >= LeseEinheitenDatenbank.Produktionskosten (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                                      IDExtern    => EinheitenDatentypen.EinheitenID (Bauprojekt.Einheit))
         then
            StadtEinheitenBauenLogik.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);

         else
            null;
         end if;
      end if;
      
   end WachstumProduktion;

end StadtwachstumLogik;
