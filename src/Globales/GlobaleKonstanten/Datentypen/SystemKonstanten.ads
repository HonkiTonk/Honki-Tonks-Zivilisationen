with SystemDatentypen;

package SystemKonstanten is
   pragma Pure;
   
   MaximaleZeichenlängeDateisystem : constant Positive := 255;
   
   LeerMeldung : constant SystemDatentypen.Spielmeldungen := SystemDatentypen.Spielmeldungen'First;

end SystemKonstanten;
