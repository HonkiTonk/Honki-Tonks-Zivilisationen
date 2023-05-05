with SystemDatentypen;

package SystemKonstanten is
   pragma Pure;
   
   MaximaleZeichenlängeDateisystem : constant Positive := 255;
   MaximaleSpielstandlängeWindows : constant Positive := 255 - 11;
   
   LeerMeldung : constant SystemDatentypen.Spielmeldungen := SystemDatentypen.Spielmeldungen'First;

end SystemKonstanten;
