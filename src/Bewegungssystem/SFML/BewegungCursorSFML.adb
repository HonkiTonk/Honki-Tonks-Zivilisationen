pragma SPARK_Mode (On);

with KartenDatentypen;
with KartenKonstanten;

with KartePositionPruefen;

package body BewegungCursorSFML is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      YÄnderungExtern : in Sf.sfInt32;
      XÄnderungExtern : in Sf.sfInt32;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        KarteExtern
      is
         when True =>
            BewegungCursorBerechnen (YÄnderungExtern => YÄnderungExtern,
                                     XÄnderungExtern => XÄnderungExtern,
                                     RasseExtern      => RasseExtern);
            
         when False =>
            null;
      end case;
      
   end BewegungCursorRichtung;
   
   

   procedure BewegungCursorBerechnen
     (YÄnderungExtern : in Sf.sfInt32;
      XÄnderungExtern : in Sf.sfInt32;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                  ÄnderungExtern    => (0, KartenDatentypen.Kartenfeld (YÄnderungExtern), KartenDatentypen.Kartenfeld (XÄnderungExtern)));
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;

         when others =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).Position := KartenWert;
      end case;
      
   end BewegungCursorBerechnen;

end BewegungCursorSFML;
