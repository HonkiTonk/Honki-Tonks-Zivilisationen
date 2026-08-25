with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with SpeziesDatentypen;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   FelderanzahlZusatzgrund : Positive;
   FelderanzahlSichtbarkeit : Positive;
   
   SichtbarkeitLadeaufteilung : SystemDatentypenHTSEB.EinByte;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   
   Speziesbelegung : SpeziesDatentypen.Spezies_Vorhanden_Enum;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

end LadenKarteLogik;
