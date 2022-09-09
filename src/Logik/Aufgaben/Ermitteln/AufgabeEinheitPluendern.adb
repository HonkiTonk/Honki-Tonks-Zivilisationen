pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with TextnummernKonstanten;

with LeseKarten;
with SchreibeKarten;
with SchreibeWichtiges;

with JaNeinLogik;

package body AufgabeEinheitPluendern is

   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
            
      if
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
        and
          LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Weg_Enum
      then
         return False;
         
      elsif
        AnlegenTestenExtern = False
      then
         return True;
         
      else
         null;
      end if;
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            null;
            
         when others =>
            if
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungPlündern) = True
            then
               null;
                     
            else
               return False;
            end if;
      end case;
      
      case
        LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            SchreibeKarten.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                         VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 10,
                                         RechnenSetzenExtern => True);
      end case;
      
      case
        LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 5,
                                         RechnenSetzenExtern => True);
      end case;
      
      return True;
      
   end VerbesserungPlündern;

end AufgabeEinheitPluendern;
