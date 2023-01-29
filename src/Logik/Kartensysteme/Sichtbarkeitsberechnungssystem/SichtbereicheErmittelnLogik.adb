with KartengrundDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body SichtbereicheErmittelnLogik is

   function SichtweiteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
   is
      use type KartenDatentypen.Ebene;
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      if
        KoordinatenEinheit.EAchse >= KartenKonstanten.OberflächeKonstante
        and
          (True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                         IDExtern             => EinheitID,
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
           or
             True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                           IDExtern             => EinheitID,
                                                           WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
      then
         return 3;
         
      else
         Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenEinheit);
      end if;
      
      -- Das hier später erweitern, beispielsweise im Dschungel auf dem Berg kürzere Sichtweite ermitteln. äöü
      -- Oder auch einheitenspezifische Eigenschaften berücksichtigen. äöü
      if
        Gesamtgrund.Basisgrund = KartengrundDatentypen.Gebirge_Enum
        or
          Gesamtgrund.Basisgrund = KartengrundDatentypen.Hügel_Enum
      then
         return 3;

      elsif
        Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Dschungel_Enum
        or
          Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Sumpf_Enum
          or
            Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Wald_Enum
      then
         return 1;
               
      else
         return 2;
      end if;
      
   end SichtweiteErmitteln;
   
   
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      KartenBlockadeWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YÄnderungExtern, XÄnderungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenBlockadeWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
         
         when others =>
            Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KartenBlockadeWert);
      end case;
         
      if
        Gesamtgrund.Basisgrund = KartengrundDatentypen.Gebirge_Enum
        or
          Gesamtgrund.Basisgrund = KartengrundDatentypen.Hügel_Enum
      then
         null;
         
      elsif
        SichtweiteExtern /= 3
        and
          (Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Dschungel_Enum
           or
             Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Sumpf_Enum
           or
             Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Wald_Enum)
      then
         null;
         
      else
         return True;
      end if;
      
      return False;
            
   end SichtbarkeitBlockadeTesten;

end SichtbereicheErmittelnLogik;
