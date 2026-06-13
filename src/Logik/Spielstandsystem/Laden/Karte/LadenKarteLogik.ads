with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with SpeziesDatentypen;

package LadenKarteLogik is
   pragma Elaborate_Body;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   AnzahlFelder : Natural;
   
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

end LadenKarteLogik;
