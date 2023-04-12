with KartenKonstanten;

with LeseWeltkarte;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body WegeplatzierungssystemLogik is
   
   procedure Wegentfernung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenverbesserungDatentypen.Weg_Enum;
   begin
      
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            if
            abs (YAchseSchleifenwert) = abs (XAchseSchleifenwert)
            then
               null;
               
            else
               Entfernungskartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                    ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                    LogikGrafikExtern => True);
            
               case
                 Entfernungskartenwert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
               
                  when others =>
                     EntfernungWeg := LeseWeltkarte.Weg (KoordinatenExtern => Entfernungskartenwert);
                     
                     if
                       EntfernungWeg = KartenverbesserungDatentypen.Leer_Weg_Enum
                     then
                        null;
                        
                     else
                        Wegplatzierung (KoordinatenExtern => Entfernungskartenwert,
                                        WegartExtern      => StandardWeg (EntfernungWeg));
                     end if;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end Wegentfernung;
   
   

   procedure Wegplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegartExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum)
   is begin
      
      Wegumgebung := (others => False);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = -1
            then
               Wegumgebung.Links := BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 1
            then
               Wegumgebung.Rechts := BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = -1
              and
                XAchseSchleifenwert = 0
            then
               Wegumgebung.Oben := BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert = 0
            then
               Wegumgebung.Unten := BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Weg_Enum'Val (Wegwert (Wegumgebung.Links, Wegumgebung.Rechts, Wegumgebung.Oben, Wegumgebung.Unten) + Wegtyp (WegartExtern)));
      
   end Wegplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeLinks (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeRechts (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
                                
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeOben (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherWeg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherWeg
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return False;
            
         when others =>
            ZwischenWeg := KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (WelcherWeg) - (Wegtyp (StandardWeg (WelcherWeg))));
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Val (WegeUnten (ZwischenWeg) + Wegtyp (StandardWeg (WelcherWeg))));
            return True;
      end case;
      
   end BerechnungUnten;

end WegeplatzierungssystemLogik;
