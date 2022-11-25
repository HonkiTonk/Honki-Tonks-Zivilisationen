with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body Basisgrundplatzierungssystem is

   procedure Basisgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
   is begin
            
      case
        BasisgrundExtern
      is
         when KartengrundDatentypen.Basisgrund_Hügel_Enum'Range | KartengrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            Grundumgebung := (others => False);
            Grundnummer := GrundZuNummer (BasisgrundExtern);
            
         when others =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => BasisgrundExtern);
            return;
      end case;
      
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
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                    GrundExtern       => KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (Basisgrundwert (Grundumgebung.Links, Grundumgebung.Rechts,
                                      Grundumgebung.Oben, Grundumgebung.Unten) + Basisgrundtyp (Grundnummer)));
      
   end Basisgrundplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Basisgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                       GrundExtern       => KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundLinks (WelcherGrund) + Basisgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Basisgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                       GrundExtern       => KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundRechts (WelcherGrund) + Basisgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Basisgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                       GrundExtern       => KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundOben (WelcherGrund) + Basisgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is begin
      
      WelcherGrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            return False;
         
         when others =>
            AndersfeldigeGrundnummer := GrundZuNummer (WelcherGrund);
      end case;
      
      if
        AndersfeldigeGrundnummer /= GrundnummerExtern
      then
         return False;
            
      else
         WelcherGrund := KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Pos (WelcherGrund) - Basisgrundtyp (AndersfeldigeGrundnummer));
         SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                       GrundExtern       => KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Val (BasisgrundUnten (WelcherGrund) + Basisgrundtyp (AndersfeldigeGrundnummer)));
         return True;
      end if;
      
   end BerechnungUnten;

end Basisgrundplatzierungssystem;
