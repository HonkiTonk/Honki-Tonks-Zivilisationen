package ForschungenDatentypen is
   pragma Pure;

   -- Die -1 wird benötigt für Gebäude/Einheiten/Forschungen die nicht möglich sind zu bauen/erforschen/unbelegt sind.
   type ForschungIDUnmöglich is range -1 .. 75;
   subtype ForschungIDMitNullWert is ForschungIDUnmöglich range 0 .. ForschungIDUnmöglich'Last;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;
   
   
   
   type Forschung_Anforderung_Enum is (
                                       Anforderung_Eins_Enum, Anforderung_Zwei_Enum, Anforderung_Drei_Enum, Anforderung_Vier_Enum
                                      );
   
   

   type AnforderungForschungArray is array (Forschung_Anforderung_Enum'Range) of ForschungIDUnmöglich;
   
   
   
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   
end ForschungenDatentypen;
