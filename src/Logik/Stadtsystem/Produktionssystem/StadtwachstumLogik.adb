with EinheitenDatentypen;
with StadtDatentypen;
with KartenverbesserungDatentypen;
with SystemDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with StadtumgebungFestlegenLogik;
with StadtEinheitenBauenLogik;
with StadtGebaeudeBauenLogik;
with StadtEntfernenLogik;
with SichtbarkeitsberechnungssystemLogik;
with MeldungenSetzenLogik;
with FelderbewirtschaftungLogik;

package body StadtwachstumLogik is
   
   procedure StadtWachstum
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesSchleifenwert) loop
                  
                  case
                    LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtSchleifenwert))
                  is
                     when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                        null;
               
                     when others =>
                        WachstumEinwohner (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtSchleifenwert));
                        WachstumProduktion (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtSchleifenwert));
                  end case;
            
               end loop StadtSchleife;
         end case;
         
      end loop SpeziesSchleife;
      
   end StadtWachstum;



   procedure WachstumEinwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          NahrungsmittelExtern   => LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                          ÄndernSetzenExtern     => True);
      
      VorhandeneNahrung := LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      if
        VorhandeneNahrung > BenötigteNahrung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      then
         WachstumSchrumpfung := NeuerEinwohner (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      elsif
        VorhandeneNahrung < StadtKonstanten.LeerNahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             NahrungsmittelExtern   => StadtKonstanten.LeerNahrungsmittel,
                                             ÄndernSetzenExtern     => False);
         
         case
           LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                              EinwohnerArbeiterExtern => True)
         is
            when 1 =>
               StadtEntfernenLogik.StadtEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               return;
               
            when others =>
               FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern   => False,
                                                                         StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               WachstumSchrumpfung := False;
         end case;
         
      else
         return;
      end if;

      EinwohnerÄnderung (StadtSpeziesNummerExtern    => StadtSpeziesNummerExtern,
                          WachstumSchrumpfungExtern => WachstumSchrumpfung);
      
   end WachstumEinwohner;
   
   
   
   function BenötigteNahrung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return GrundwertEinwohnerwachstum (StadtSpeziesNummerExtern.Spezies)
        + MultiplikatorEinwohnerwachstum (StadtSpeziesNummerExtern.Spezies) * ProduktionDatentypen.Produktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                                                                                                              EinwohnerArbeiterExtern => True));
      
   end BenötigteNahrung;
   
   
   
   function NeuerEinwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          NahrungsmittelExtern   => StadtKonstanten.LeerNahrungsmittel,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             WachsenSchrumpfenExtern => True);
      FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern   => True,
                                                                StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      return True;
      
   end NeuerEinwohner;
   
   
   
   procedure EinwohnerÄnderung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                                                                EinwohnerArbeiterExtern => True);
      
      case
        WachstumSchrumpfungExtern
      is
         when True =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern         => StadtDatentypen.Einwohner_Wachstum_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtSpeziesNummerExtern.Spezies)
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtSpeziesNummerExtern.Spezies)
            then
               StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               SichtbarkeitsberechnungssystemLogik.SichtbarkeitsprüfungFürStadt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern         => StadtDatentypen.Einwohner_Reduktion_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtSpeziesNummerExtern.Spezies) - 1
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtSpeziesNummerExtern.Spezies) - 1
            then
               StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end EinwohnerÄnderung;
   
   
   
   procedure WachstumProduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      RessourcenExtern       => LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                      ÄndernSetzenExtern     => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
        
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                         ÄndernSetzenExtern     => False);
         
      elsif
        Bauprojekt.Gebäude /= 0
      then
         if
           LeseStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) >= LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                     IDExtern    => StadtDatentypen.GebäudeID (Bauprojekt.Gebäude))
         then
            StadtGebaeudeBauenLogik.GebäudeFertiggestellt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         else
            null;
         end if;
         
      else
         if
           LeseStadtGebaut.Ressourcen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) >= LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                      IDExtern    => EinheitenDatentypen.EinheitenID (Bauprojekt.Einheit))
         then
            StadtEinheitenBauenLogik.EinheitFertiggestellt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

         else
            null;
         end if;
      end if;
      
   end WachstumProduktion;

end StadtwachstumLogik;
