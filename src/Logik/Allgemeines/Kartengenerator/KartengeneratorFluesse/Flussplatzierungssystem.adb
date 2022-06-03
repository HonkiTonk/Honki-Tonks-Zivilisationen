pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with LeseKarten;
with SchreibeKarten;

with Kartenkoordinatenberechnungssystem;

package body Flussplatzierungssystem is

   procedure FlussBerechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert (KoordinatenExtern.EAchse) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                            ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                                            LogikGrafikExtern => True);

            case
              KartenWert (KoordinatenExtern.EAchse).XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  if
                    YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = -1
                  then
                     BerechnungLinks (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
                  elsif
                    YÄnderungSchleifenwert = 0
                    and
                      XÄnderungSchleifenwert = 1
                  then
                     BerechnungRechts (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
                  elsif
                    YÄnderungSchleifenwert = -1
                    and
                      XÄnderungSchleifenwert = 0
                  then
                     BerechnungOben (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
                  elsif
                    YÄnderungSchleifenwert = 1
                    and
                      XÄnderungSchleifenwert = 0
                  then
                     BerechnungUnten (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse));
               
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      FlussPlatzieren (KoordinatenExtern => KoordinatenExtern);
      
   end FlussBerechnung;
   
   
   
   procedure BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussLinks (KoordinatenExtern.EAchse) := False;
            
         when others =>
            FlussLinks (KoordinatenExtern.EAchse) := True;
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseLinks (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      end case;
            
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussRechts (KoordinatenExtern.EAchse) := False;
            
         when others =>
            FlussRechts (KoordinatenExtern.EAchse) := True;
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseRechts (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      end case;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussOben (KoordinatenExtern.EAchse) := False;
            
         when others =>
            FlussOben (KoordinatenExtern.EAchse) := True;
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseOben (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      end case;
            
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      WelcherFluss (KoordinatenExtern.EAchse) := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherFluss (KoordinatenExtern.EAchse)
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            FlussUnten (KoordinatenExtern.EAchse) := False;
            
         when others =>
            FlussUnten (KoordinatenExtern.EAchse) := True;
            WelcherFluss (KoordinatenExtern.EAchse)
              := KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Val (KartengrundDatentypen.Kartenfluss_Oberfläche_Enum'Pos (WelcherFluss (KoordinatenExtern.EAchse)) - Flusstyp (KoordinatenExtern.EAchse));
            SchreibeKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse),
                                  FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (FlüsseUnten (WelcherFluss (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      end case;
      
   end BerechnungUnten;
   
   
   
   procedure FlussPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SchreibeKarten.Fluss (KoordinatenExtern => KoordinatenExtern,
                            FlussExtern       => KartengrundDatentypen.Kartenfluss_Enum'Val (Flusswert (FlussLinks (KoordinatenExtern.EAchse), FlussRechts (KoordinatenExtern.EAchse),
                              FlussOben (KoordinatenExtern.EAchse), FlussUnten (KoordinatenExtern.EAchse)) + Flusstyp (KoordinatenExtern.EAchse)));
      
   end FlussPlatzieren;

end Flussplatzierungssystem;
