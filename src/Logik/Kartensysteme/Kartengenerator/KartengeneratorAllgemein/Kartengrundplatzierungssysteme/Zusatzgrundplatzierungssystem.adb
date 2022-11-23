with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body Zusatzgrundplatzierungssystem is

   procedure Zusatzgrundplatzierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
   is begin
      
      ZusatzgrundVorhanden := (others => False);
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
               ZusatzgrundVorhanden.Links := BerechnungLinks (KoordinatenExtern => Kartenwert,
                                                              GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 1
            then
               ZusatzgrundVorhanden.Rechts := BerechnungRechts (KoordinatenExtern => Kartenwert,
                                                                GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = -1
              and
                XAchseSchleifenwert = 0
            then
               ZusatzgrundVorhanden.Oben := BerechnungOben (KoordinatenExtern => Kartenwert,
                                                            GrundnummerExtern => Grundnummer);
               
            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert = 0
            then
               ZusatzgrundVorhanden.Unten := BerechnungUnten (KoordinatenExtern => Kartenwert,
                                                              GrundnummerExtern => Grundnummer);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => ZusatzgrundExtern);
      
   end Zusatzgrundplatzierung;
   
   
   
   function BerechnungLinks
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        WelcherGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         return False;
         
      elsif
        GrundZuNummer (WelcherGrund) /= GrundnummerExtern
      then
         return False;
            
      else
         return True;
      end if;
            
   end BerechnungLinks;
   
   
   
   function BerechnungRechts
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        WelcherGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         return False;
         
      elsif
        GrundZuNummer (WelcherGrund) /= GrundnummerExtern
      then
         return False;
            
      else
         return True;
      end if;
      
   end BerechnungRechts;
   
   
   
   function BerechnungOben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        WelcherGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         return False;
         
      elsif
        GrundZuNummer (WelcherGrund) /= GrundnummerExtern
      then
         return False;
            
      else
         return True;
      end if;
            
   end BerechnungOben;
   
   
   
   function BerechnungUnten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundnummerExtern : in Positive)
      return Boolean
   is
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      WelcherGrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        WelcherGrund = KartengrundDatentypen.Leer_Zusatzgrund_Enum
      then
         return False;
         
      elsif
        GrundZuNummer (WelcherGrund) /= GrundnummerExtern
      then
         return False;
            
      else
         return True;
      end if;
      
   end BerechnungUnten;

end Zusatzgrundplatzierungssystem;
