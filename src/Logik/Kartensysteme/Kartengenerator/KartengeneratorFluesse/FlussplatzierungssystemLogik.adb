with KartenKonstanten;

with LeseWeltkarte;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body FlussplatzierungssystemLogik is

   procedure Flussplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      FlussLinks (KoordinatenExtern.EAchse) := False;
      FlussRechts (KoordinatenExtern.EAchse) := False;
      FlussOben (KoordinatenExtern.EAchse) := False;
      FlussUnten (KoordinatenExtern.EAchse) := False;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert (KoordinatenExtern.EAchse) := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                 ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                                        YAchseSchleifenwert,
                                                                                                                                                        XAchseSchleifenwert),
                                                                                                                                 LogikGrafikExtern => True);

            if
              KartenWert (KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                  
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = -1
            then
               FlussLinks (KoordinatenExtern.EAchse) := BerechnungLinks (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 1
            then
               FlussRechts (KoordinatenExtern.EAchse) := BerechnungRechts (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YAchseSchleifenwert = -1
              and
                XAchseSchleifenwert = 0
            then
               FlussOben (KoordinatenExtern.EAchse) := BerechnungOben (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert = 0
            then
               FlussUnten (KoordinatenExtern.EAchse) := BerechnungUnten (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (Flusswert (FlussLinks (KoordinatenExtern.EAchse), FlussRechts (KoordinatenExtern.EAchse),
                                 FlussOben (KoordinatenExtern.EAchse), FlussUnten (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      
   end Flussplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                     FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseLinks (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                     FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseRechts (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                     FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseOben (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                     FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseUnten (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
            return True;
      end case;
      
   end BerechnungUnten;

end FlussplatzierungssystemLogik;
