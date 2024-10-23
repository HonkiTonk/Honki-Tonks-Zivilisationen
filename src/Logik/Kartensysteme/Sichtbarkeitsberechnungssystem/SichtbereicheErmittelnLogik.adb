with KartengrundDatentypen;
with SystemDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body SichtbereicheErmittelnLogik is

   function SichtweiteErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.SichtweitePositiveRecord
   is
      use type KartenDatentypen.Ebene;
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      if
        KoordinatenEinheit.Ebene >= KartenKonstanten.OberflächeKonstante
        and
          (True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                         IDExtern             => EinheitID,
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
           or
             True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                           IDExtern             => EinheitID,
                                                           WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
      then
         return (3, 3);
         
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
         return (3, 3);

      elsif
        Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Dschungel_Enum
        or
          Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Sumpf_Enum
          or
            Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Wald_Enum
      then
         return (1, 1);
               
      else
         return (2, 2);
      end if;
      
   end SichtweiteErmitteln;
   
   
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SenkrechteÄnderungExtern : in KartenDatentypen.SenkrechteUmgebungZwei;
      WaagerechteÄnderungExtern : in KartenDatentypen.WaagerechteUmgebungZwei;
      SichtweiteExtern : in KartenRecords.UmgebungDreiRecord)
      return Boolean
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Zusatzgrund_Enum;
   begin
      
      KartenBlockadeWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteÄnderungExtern, WaagerechteÄnderungExtern),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenBlockadeWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
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
        (SichtweiteExtern.Senkrechte /= 3
         or
           SichtweiteExtern.Waagerechte /= 3)
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
