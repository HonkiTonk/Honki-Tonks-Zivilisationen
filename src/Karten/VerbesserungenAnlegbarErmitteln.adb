pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenAllgemein;

package body VerbesserungenAnlegbarErmitteln is

   function VerbesserungenAnlegbar
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      WelcheVerbesserungExtern : in GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum)
      return Boolean
   is begin
      
      if
        GlobaleKonstanten.TechnologieVerbesserung (RasseExtern, WelcheVerbesserungExtern) = -1
      then
         return False;
         
      elsif
        GlobaleKonstanten.TechnologieVerbesserung (RasseExtern, WelcheVerbesserungExtern) = 0
      then
         null;
         
      elsif
        GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (GlobaleKonstanten.TechnologieVerbesserung (RasseExtern, WelcheVerbesserungExtern)) = False
      then
         return False;
               
      else
         null;
      end if;
      
      case
        WelcheVerbesserungExtern
      is
         when GlobaleDatentypen.Straße_Bauen =>
            if
              KartenAllgemein.FeldWeg (PositionExtern => KoordinatenExtern) in GlobaleDatentypen.Karten_Verbesserung_Weg_Enum'Range
            then
               return False;
               
            else
               null;
            end if;
            
         when Mine_Bauen =>
            if
              KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) = GlobaleDatentypen.Mine
            then
               return False;
               
            else
               null;
            end if;
            
         when Farm_Bauen =>
            if
              KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) = GlobaleDatentypen.Farm
            then
               return False;
               
            else
               null;
            end if;
            
         when Festung_Bauen =>
            if
              KartenAllgemein.FeldVerbesserung (PositionExtern => KoordinatenExtern) = GlobaleDatentypen.Festung
            then
               return False;
               
            else
               null;
            end if;
            
         when Wald_Aufforsten =>
            if
              KartenAllgemein.FeldGrund (PositionExtern => KoordinatenExtern) = GlobaleDatentypen.Wald
            then
               return False;
               
            else
               null;
            end if;
            
         when Roden_Trockenlegen =>
            if
              KartenAllgemein.FeldGrund (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Sumpf
              and
                KartenAllgemein.FeldGrund (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Wald
              and
                KartenAllgemein.FeldGrund (PositionExtern => KoordinatenExtern) /= GlobaleDatentypen.Dschungel
            then
               return False;
               
            else
               null;
            end if;
      end case;
            
      return True;
      
   end VerbesserungenAnlegbar;

end VerbesserungenAnlegbarErmitteln;
