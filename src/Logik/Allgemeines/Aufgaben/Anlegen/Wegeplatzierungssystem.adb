pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with KartenKonstanten;

with LeseKarten;
with SchreibeKarten;

with Kartenkoordinatenberechnungssystem;

package body Wegeplatzierungssystem is

   procedure WegBerechnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
   is begin
      
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
               BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      WegPlatzieren (KoordinatenExtern => KoordinatenExtern,
                     WegartExtern      => WegartExtern);
      
   end WegBerechnen;
   
   
   
   procedure BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegLinks := False;
            
         when others =>
            WegLinks := True;
            ZwischenWeg := KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeLinks (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
      end case;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegRechts := False;
            
         when others =>
            WegRechts := True;
            ZwischenWeg := KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeRechts (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
      end case;
      
   end BerechnungRechts;
   
   
                                
   procedure BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegOben := False;
            
         when others =>
            WegOben := True;
            ZwischenWeg := KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeOben (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
      end case;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegUnten := False;
            
         when others =>
            WegUnten := True;
            ZwischenWeg := KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeUnten (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
      end case;
      
   end BerechnungUnten;
   
   
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
   is begin
      
      SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                          WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Enum'Val (Wegwert (WegLinks, WegRechts, WegOben, WegUnten) + Wegtyp (WegartExtern)));
      
   end WegPlatzieren;

end Wegeplatzierungssystem;
