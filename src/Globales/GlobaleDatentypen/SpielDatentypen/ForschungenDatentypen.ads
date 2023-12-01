package ForschungenDatentypen is
   pragma Pure;

   -- Die -1 wird benötigt für Gebäude/Einheiten/Forschungen die nicht möglich sind zu bauen/erforschen/unbelegt sind.
   type ForschungIDUnmöglich is range -1 .. 75;
   subtype ForschungID is ForschungIDUnmöglich range 0 .. ForschungIDUnmöglich'Last;
   subtype ForschungIDVorhanden is ForschungID range 1 .. ForschungID'Last;
   
   
   
   type Forschung_Anforderung_Enum is (
                                       Anforderung_Eins_Enum, Anforderung_Zwei_Enum, Anforderung_Drei_Enum, Anforderung_Vier_Enum
                                      );
   
   

   type AnforderungForschungArray is array (Forschung_Anforderung_Enum'Range) of ForschungIDUnmöglich;
   
   
   
   type ErforschtArray is array (ForschungIDVorhanden'Range) of Boolean;
   
end ForschungenDatentypen;
