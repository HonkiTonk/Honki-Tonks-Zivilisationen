pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartengrundDatentypen;
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
      
      Bewegungsbonus := StraßeUndFlussPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                NeueKoordinatenExtern    => NeueKoordinatenExtern);

      case
        LeseWeltkarte.AktuellerGrund (KoordinatenExtern => NeueKoordinatenExtern)
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            if
              LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) < KleinerAbzug - Bewegungsmodifikator (Bewegungsbonus)
            then
               return EinheitenKonstanten.EinheitUnbewegbar;
      
            elsif
              MittlererAbzug - Bewegungsmodifikator (Bewegungsbonus) <= KeinAbzug
            then
               return KeinAbzug;
               
            else
               return MittlererAbzug - Bewegungsmodifikator (Bewegungsbonus);
            end if;
            
         when others =>
            if
              KleinerAbzug - Bewegungsmodifikator (Bewegungsbonus) <= KeinAbzug
            then
               return KeinAbzug;
            
            else
               return KleinerAbzug - Bewegungsmodifikator (Bewegungsbonus);
            end if;
      end case;
      
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
               return Straße_Fluss_Enum;
               
            when KartenverbesserungDatentypen.Karten_Schiene_Enum'Range =>
               return Schiene_Enum;
               
            when KartenverbesserungDatentypen.Karten_Tunnel_Enum =>
               return Straße_Fluss_Enum;
                  
            when others =>
               null;
         end case;

         case
           LeseWeltkarte.Fluss (KoordinatenExtern => NeueKoordinatenExtern)
         is
            when KartengrundDatentypen.Leer_Fluss_Enum =>
               null;

            when others =>
               return Straße_Fluss_Enum;
         end case;

      else
         null;
      end if;
      
      return Leer_Enum;
      
   end StraßeUndFlussPrüfen;

end BewegungspunkteBerechnenLogik;
