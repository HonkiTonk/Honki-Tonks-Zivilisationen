with SchreibeWeltkarte;

package body FeldeffektEntfernenLogik is

   procedure FeldeffektEntfernen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldeffektExtern : in AufgabenDatentypen.Einheitenbefehle_Gelände_Enum)
   is begin
      
      -- Durch FeldeffektExtern später den zu entfernden Effekt mitübergeben? äöü
      -- Oder hier erneut prüfen welchen Effekt man entfernen kann? äöü
      case
        FeldeffektExtern
      is
         when others =>
            SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => KoordinatenExtern,
                                               FeldeffekteExtern => False);
      end case;
      
   end FeldeffektEntfernen;

end FeldeffektEntfernenLogik;
