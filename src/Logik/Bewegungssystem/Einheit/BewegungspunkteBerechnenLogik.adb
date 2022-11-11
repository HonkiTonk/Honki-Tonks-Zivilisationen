with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenverbesserungDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseWeltkarte;
with LeseEinheitenGebaut;

package body BewegungspunkteBerechnenLogik is

   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.BewegungFloat
   is begin
      
      Bewegungsbonus := Bewegungsmodifikator (StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      NeueKoordinatenExtern    => NeueKoordinatenExtern));
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => NeueKoordinatenExtern);
      
      if
        Gesamtgrund.Basisgrund = KartengrundDatentypen.Eis_Enum
        or
          Gesamtgrund.Basisgrund = KartengrundDatentypen.Untereis_Enum
          or
            Gesamtgrund.Basisgrund = KartengrundDatentypen.Gebirge_Enum
            or
              Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Dschungel_Enum
              or
                Gesamtgrund.Zusatzgrund = KartengrundDatentypen.Sumpf_Enum
      then
         if
           LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) < KleinerAbzug - Bewegungsbonus
         then
            return EinheitenKonstanten.EinheitUnbewegbar;
      
         elsif
           MittlererAbzug - Bewegungsbonus <= KeinAbzug
         then
            return KeinAbzug;
               
         else
            return MittlererAbzug - Bewegungsbonus;
         end if;
            
      else
         if
           KleinerAbzug - Bewegungsbonus <= KeinAbzug
         then
            return KeinAbzug;
            
         else
            return KleinerAbzug - Bewegungsbonus;
         end if;
      end if;
      
   end AbzugDurchBewegung;

   

   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Bewegungsbonus_Enum
   is begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      if
        False = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern             => EinheitID,
                                                       WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
        and
          False = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern             => EinheitID,
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum)
      then
         case
           LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartenverbesserungDatentypen.Karten_Straße_Enum'Range =>
               return Straße_Enum;
               
            when KartenverbesserungDatentypen.Karten_Schiene_Enum'Range =>
               return Schiene_Enum;
               
            when KartenverbesserungDatentypen.Karten_Tunnel_Enum =>
               return Tunnel_Enum;
                  
            when others =>
               null;
         end case;

         case
           LeseWeltkarte.Fluss (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartengrundDatentypen.Leer_Fluss_Enum =>
               null;
               
            when KartengrundDatentypen.Kartenfluss_Kern_Enum'Range =>
               null;

            when others =>
               return Fluss_Enum;
         end case;

      else
         null;
      end if;
      
      return Leer_Enum;
      
   end StraßeUndFlussPrüfen;

end BewegungspunkteBerechnenLogik;
