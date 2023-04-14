with SystemDatentypen;
with StadtDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with StadtumgebungFestlegenLogik;
with StadtEntfernenLogik;
with SichtbarkeitsberechnungssystemLogik;
with MeldungenSetzenLogik;
with FelderbewirtschaftungLogik;

package body StadtbewohnerwachstumLogik is

   procedure Einwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          NahrungsmittelExtern     => LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                          ÄndernSetzenExtern       => True);
      
      VorhandeneNahrung := LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      if
        VorhandeneNahrung > BenötigteNahrung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      then
         WachstumSchrumpfung := NeuerEinwohner (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      elsif
        VorhandeneNahrung < StadtKonstanten.LeerNahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             NahrungsmittelExtern     => StadtKonstanten.LeerNahrungsmittel,
                                             ÄndernSetzenExtern       => False);
         
         case
           LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              EinwohnerArbeiterExtern  => True)
         is
            when 1 =>
               StadtEntfernenLogik.StadtEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               return;
               
            when others =>
               FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern     => False,
                                                                         StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               WachstumSchrumpfung := False;
         end case;
         
      else
         return;
      end if;

      EinwohnerÄnderung (StadtSpeziesNummerExtern  => StadtSpeziesNummerExtern,
                          WachstumSchrumpfungExtern => WachstumSchrumpfung);
      
   end Einwohner;
   
   
   
   function BenötigteNahrung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return GrundwertEinwohnerwachstum (StadtSpeziesNummerExtern.Spezies)
        + MultiplikatorEinwohnerwachstum (StadtSpeziesNummerExtern.Spezies) * ProduktionDatentypen.Produktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                                  EinwohnerArbeiterExtern  => True));
      
   end BenötigteNahrung;
   
   
   
   function NeuerEinwohner
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          NahrungsmittelExtern     => StadtKonstanten.LeerNahrungsmittel,
                                          ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             EinwohnerArbeiterExtern  => True,
                                             WachsenSchrumpfenExtern  => True);
      FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern     => True,
                                                                StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      return True;
      
   end NeuerEinwohner;
   
   
   
   procedure EinwohnerÄnderung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                EinwohnerArbeiterExtern  => True);
      
      case
        WachstumSchrumpfungExtern
      is
         when True =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     EreignisExtern           => StadtDatentypen.Einwohner_Wachstum_Enum);
            
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
                                                     EreignisExtern           => StadtDatentypen.Einwohner_Reduktion_Enum);
            
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

end StadtbewohnerwachstumLogik;
