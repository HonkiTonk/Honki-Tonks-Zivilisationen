pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

package body VerbesserungAnlegen is

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
   is begin
      
      case
        VerbesserungExtern
      is
         when AufgabenDatentypen.Mine_Bauen_Enum =>
            WelcheVerbesserung := KartenVerbesserungDatentypen.Mine_Enum;
            
         when AufgabenDatentypen.Farm_Bauen_Enum =>
            WelcheVerbesserung := KartenVerbesserungDatentypen.Farm_Enum;
            
         when AufgabenDatentypen.Festung_Bauen_Enum =>
            WelcheVerbesserung := KartenVerbesserungDatentypen.Festung_Enum;
      end case;
      
      SchreibeKarten.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                   VerbesserungExtern => WelcheVerbesserung);
      
   end VerbesserungAnlegen;

end VerbesserungAnlegen;
