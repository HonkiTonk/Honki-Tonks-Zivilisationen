pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseKarten;
with SchreibeKarten;

with Kartenkoordinatenberechnungssystem;

package body WegeplatzierungssystemLogik is

   procedure Wegplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
   is begin
      
      WegLinks := False;
      WegRechts := False;
      WegOben := False;
      WegUnten := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               WegLinks := BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               WegRechts := BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               WegOben := BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               WegUnten := BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                          WegExtern         => KartenverbesserungDatentypen.Karten_Weg_Enum'Val (Wegwert (WegLinks, WegRechts, WegOben, WegUnten) + Wegtyp (WegartExtern)));
      
   end Wegplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeLinks (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeRechts (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
                                
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeOben (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeUnten (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungUnten;

end WegeplatzierungssystemLogik;
