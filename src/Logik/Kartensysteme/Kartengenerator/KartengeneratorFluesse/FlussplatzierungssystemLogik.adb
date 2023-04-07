with LeseWeltkarte;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body FlussplatzierungssystemLogik is

   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Flussseite := (others => False);
      
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
               Flussseite.Links := BerechnungLinks (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 1
            then
               Flussseite.Rechts := BerechnungRechts (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = -1
              and
                XAchseSchleifenwert = 0
            then
               Flussseite.Oben := BerechnungOben (KoordinatenExtern => KartenWert);
               
            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert = 0
            then
               Flussseite.Unten := BerechnungUnten (KoordinatenExtern => KartenWert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (Flusswert (Flussseite.Links, Flussseite.Rechts,
                                 Flussseite.Oben, Flussseite.Unten) + Flusstyp (KoordinatenExtern.EAchse)));
      
   end Flussplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseLinks (WelcherFluss) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseRechts (WelcherFluss) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss := KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseOben (WelcherFluss) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss:= KartenextraDatentypen.Fluss_Oberfläche_Enum'Val (KartenextraDatentypen.Fluss_Oberfläche_Enum'Pos (WelcherFluss) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => KartenextraDatentypen.Fluss_Enum'Val (FlüsseUnten (WelcherFluss) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungUnten;

end FlussplatzierungssystemLogik;
