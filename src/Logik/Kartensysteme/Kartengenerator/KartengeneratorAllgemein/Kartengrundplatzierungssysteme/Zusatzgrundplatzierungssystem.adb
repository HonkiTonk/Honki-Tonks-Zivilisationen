with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body Zusatzgrundplatzierungssystem is
   
   procedure Zusatzgrundentfernung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
            
      AktuellerGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
            
      case
        AktuellerGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => KartengrundDatentypen.Leer_Zusatzgrund_Enum);
      end case;
      
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
                     NebenfeldGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => Entfernungskartenwert);
                     
                     if
                       NebenfeldGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
                     then
                        null;
                        
                     elsif
                       GrundZuNummer (AktuellerGrund) /= GrundZuNummer (NebenfeldGrund)
                     then
                        null;
                  
                     else
                        Zusatzgrundplatzierung (KoordinatenExtern => Entfernungskartenwert,
                                                ZusatzgrundExtern => AktuellerGrund);
                     end if;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end Zusatzgrundentfernung;
   
   

   procedure Zusatzgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
   is begin
      
      Grundumgebung := (others => False);
      Grundnummer := GrundZuNummer (ZusatzgrundExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                  
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = -1
            then
               Grundumgebung.Links := BerechnungLinks (KoordinatenExtern => Kartenwert,
                                                       GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 1
            then
               Grundumgebung.Rechts := BerechnungRechts (KoordinatenExtern => Kartenwert,
                                                         GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = -1
              and
                XAchseSchleifenwert = 0
            then
               Grundumgebung.Oben := BerechnungOben (KoordinatenExtern => Kartenwert,
                                                     GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert = 0
            then
               Grundumgebung.Unten := BerechnungUnten (KoordinatenExtern => Kartenwert,
                                                       GrundnummerExtern => Grundnummer);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (Zusatzgrundwert (Grundumgebung.Links, Grundumgebung.Rechts,
                                       Grundumgebung.Oben, Grundumgebung.Unten) + Zusatzgrundtyp (Grundnummer)));
            
   end Zusatzgrundplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundLinks (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundRechts (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundOben (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Pos (WelcherGrund) - Zusatzgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Val (ZusatzgrundUnten (WelcherGrund) + Zusatzgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungUnten;

end Zusatzgrundplatzierungssystem;
